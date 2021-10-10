//
//  FollowerListVC.swift
//  github-followers
//
//  Created by Mark Battistella on 6/10/21.
//

import UIKit

class FollowerListVC: GFDataLoadingVC {
	
	enum Section {
		case main
	}
	
	var username: String!
	var followers: [FollowerModel] = []
	var filteredFollowers: [FollowerModel] = []
	var page = 1
	var hasMoreFollowers = true
	var isSearching = false
	var isLoading = false
	
	var collectionView: UICollectionView!
	var dataSource: UICollectionViewDiffableDataSource<Section, FollowerModel>!

	init(username: String) {
		super.init(nibName: nil, bundle: nil)
		self.username = username
		title = username
	}
	
	// storyboard
	required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
	
    override func viewDidLoad() {
        super.viewDidLoad()
		configureViewController()
		configureSearchController()
		configureCollectionView()
		getFollowers(username: username, page: page)
		configureDataSource()
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationController?.setNavigationBarHidden(false, animated: true)
	}
	
	func configureViewController() {
		view.backgroundColor = .systemBackground
		navigationController?.navigationBar.prefersLargeTitles = true

		let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
		navigationItem.rightBarButtonItem = addButton
	}
	
	func configureCollectionView() {
		collectionView = UICollectionView(
			frame: view.bounds,
			collectionViewLayout: UIHelper.createColumnFlowLayout(in: view, columns: 3)
		)
		view.addSubview(collectionView)
		collectionView.delegate = self
		collectionView.backgroundColor = .systemBackground
		collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.resuseID)
	}
	
	func configureSearchController() {
		let searchController = UISearchController()
		searchController.searchResultsUpdater = self
		searchController.searchBar.placeholder = "Search for a username"
		searchController.obscuresBackgroundDuringPresentation = false
		navigationItem.searchController = searchController
	}
	
	func getFollowers(username: String, page: Int) {
		
		// show the activity indicator
		showLoadingView()
		
		isLoading = true

		NetworkManager.shared.getFollowers(for: username, page: page) { [weak self] result in
			
			// for weak self
			guard let self = self else { return }

			// remove the loading
			self.dismissLoadingView()

			// -- switch on the results
			switch result {
				case .success(let followers):
					
					// -- check the return has less than 100 follower
					if(followers.count < 100) {
						
						// dont call more
						self.hasMoreFollowers = false
					}
					
					// append to array so we have incremental list
					self.followers.append(contentsOf: followers)
					
					// if there are no followers
					if(self.followers.isEmpty) {
						
						// show the empty view
						let message = "This user doesnt have any followers! Go follow them"
						DispatchQueue.main.async {
							self.showEmptyStateView(with: message, in: self.view)
							return
						}
					}
					
					// if there are followers and we need to update the view
					self.updateData(on: self.followers)
					
				case .failure(let error):
					self.presentGFAlertOnMainThread(
						title: "Bad stuff happened",
						message: error.rawValue,
						buttonTitle: "OK"
					)
			}
			
			self.isLoading = false
		}
	}
	
	func configureDataSource() {
		dataSource = UICollectionViewDiffableDataSource<Section, FollowerModel>(collectionView: collectionView, cellProvider: {
			(collectionView, indexPath, follower) -> UICollectionViewCell? in
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.resuseID, for: indexPath) as! FollowerCell
			cell.set(follower: follower)
			return cell
		})
	}
	
	func updateData(on followers: [FollowerModel]) {
		var snapshot = NSDiffableDataSourceSnapshot<Section, FollowerModel>()
		snapshot.appendSections([.main])
		snapshot.appendItems(followers)
		DispatchQueue.main.async {
			self.dataSource.apply(snapshot, animatingDifferences: true)
		}
	}
	
	@objc func addButtonTapped() {
		showLoadingView()
		NetworkManager.shared.getUserInfo(for: username) { [weak self] result in

			guard let self = self else { return }

			self.dismissLoadingView()

			switch result {
				case .success(let user):
					
					let favourite = FollowerModel(login: user.login, avatarUrl: user.avatarUrl)
					
					PersistenceManager.updateWith(favourite: favourite, actionType: .add) { [weak self] error in

						guard let self = self else { return }

						guard let error = error else {
							self.presentGFAlertOnMainThread(
								title: "Success!",
								message: "You have favourited a user",
								buttonTitle: "YAY!"
							)
							return
						}

						self.presentGFAlertOnMainThread(
							title: "Something went wrong",
							message: error.rawValue,
							buttonTitle: "OK"
						)
					}
				
				case .failure(let error):
					self.presentGFAlertOnMainThread(
						title: "Something went wrong",
						message: error.rawValue,
						buttonTitle: "OK"
					)
			}
		}
	}
}

extension FollowerListVC: UICollectionViewDelegate {
	
	// when scrolling on list
	func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
		let offsetY = scrollView.contentOffset.y
		let contentHeight = scrollView.contentSize.height
		let height = scrollView.frame.size.height
		
		if(offsetY > (contentHeight - height)) {
			guard hasMoreFollowers, !isLoading else { return }
			page += 1
			getFollowers(username: username, page: page)
		}
	}
	
	// when tapping cell
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		
		// get the correct array
		let activeArray = isSearching ? filteredFollowers : followers
		
		// selected follower
		let follower = activeArray[indexPath.item]
		
		// where to go
		let destinationVC = UserInfoVC()
		destinationVC.username = follower.login
		destinationVC.delegate = self
		let navController = UINavigationController(rootViewController: destinationVC)
		present(navController, animated: true)
	}
}

extension FollowerListVC: UISearchResultsUpdating {
	
	// when entering text into search bar
	func updateSearchResults(for searchController: UISearchController) {
		
		// check the typed text is not empty
		guard let filter = searchController.searchBar.text, !filter.isEmpty else {
			filteredFollowers.removeAll()
			updateData(on: followers)
			isSearching = false
			return
		}
		
		// flip the state
		isSearching = true
		
		// filter out array with matches
		filteredFollowers = followers.filter {
			$0.login.lowercased().contains(filter.lowercased())
		}
		
		// update the collection view
		updateData(on: filteredFollowers)
	}
}

extension FollowerListVC: UserInfoVCDelegate {
	
	func didRequestFollowers(for username: String) {
		self.username = username
		title = username
		page = 1
		followers.removeAll()
		filteredFollowers.removeAll()
		collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: false)
		getFollowers(username: username, page: page)
	}
}

//
//  FollowerListVC.swift
//  github-followers
//
//  Created by Mark Battistella on 6/10/21.
//

import UIKit

class FollowerListVC: UIViewController {
	
	enum Section {
		case main
	}
	
	var username: String!
	var followers: [FollowerModel] = []
	var page = 1
	var hasMoreFollowers = true
	
	var collectionView: UICollectionView!
	var dataSource: UICollectionViewDiffableDataSource<Section, FollowerModel>!

    override func viewDidLoad() {
        super.viewDidLoad()
		configureCollectionView()
		configureViewController()
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
	
	func getFollowers(username: String, page: Int) {
		NetworkManager.shared.getFollowers(for: username, page: page) { [weak self] result in
			
			guard let self = self else { return }
			
			// -- switch on the results
			switch result {
				case .success(let followers):
					if(followers.count < 100) {
						self.hasMoreFollowers = false
					}
					self.followers.append(contentsOf: followers)
					self.updateData()
					
				case .failure(let error):
					self.presentGFAlertOnMainThread(
						title: "Bad stuff happened",
						message: error.rawValue,
						buttonTitle: "OK"
					)
			}
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
	
	func updateData() {
		var snapshot = NSDiffableDataSourceSnapshot<Section, FollowerModel>()
		snapshot.appendSections([.main])
		snapshot.appendItems(followers)
		DispatchQueue.main.async {
			self.dataSource.apply(snapshot, animatingDifferences: true)
		}
	}
}

extension FollowerListVC: UICollectionViewDelegate {
	
	func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
		let offsetY = scrollView.contentOffset.y
		let contentHeight = scrollView.contentSize.height
		let height = scrollView.frame.size.height
		
		if(offsetY > (contentHeight - height)) {
			guard hasMoreFollowers else { return }
			page += 1
			getFollowers(username: username, page: page)
		}
	}
}

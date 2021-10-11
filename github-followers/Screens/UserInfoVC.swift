//
//  UserInfoVC.swift
//  github-followers
//
//  Created by Mark Battistella on 8/10/21.
//

import UIKit

protocol UserInfoVCDelegate: AnyObject {
	func didRequestFollowers(for username: String)
}

class UserInfoVC: GFDataLoadingVC {
	
	let scrollView = UIScrollView()
	let contentView = UIView()
	
	let headerView = UIView()
	let itemViewOne = UIView()
	let itemViewTwo = UIView()
	let dateLabel = GFBodyLabel(textAlignment: .center)
	
	var itemViews: [UIView] = []
	
	var username: String!
	weak var delegate: UserInfoVCDelegate!
	
	// what override from default
	override func viewDidLoad() {
		super.viewDidLoad()
		configureViewController()
		configureScrollView()
		layoutUI()
		getUserInfo()
	}
	
	// -- main setup
	func configureViewController() {
		view.backgroundColor = .systemBackground
		let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
		navigationItem.rightBarButtonItem = doneButton
	}
	
	// -- network call
	func getUserInfo() {
		
		Task {
			do {
				let user = try await NetworkManager.shared.getUserInfo(for: username)
				configureUIElements(with: user)
			} catch {
				if let error = error as? GFError {
					presentGFAlert(
						title: "Something went wrong",
						message: error.rawValue,
						buttonTitle: "OK"
					)
				} else {
					presentDefaultError()
				}
			}
		}
	}
	
	func configureScrollView() {
		view.addSubview(scrollView)
		scrollView.addSubview(contentView)
		scrollView.pinToEdges(of: view)
		contentView.pinToEdges(of: scrollView)
		
		NSLayoutConstraint.activate([
			contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
			contentView.heightAnchor.constraint(equalToConstant: 600)
		])
	}
	
	func configureUIElements(with user: UserModel) {
		self.add(childVC: GFUserInfoHeaderVC(user: user), to: self.headerView)
		self.add(childVC: GFRepoItemVC(user: user, delegate: self), to: self.itemViewOne)
		self.add(childVC: GFFollowerItemVC(user: user, delegate: self), to: self.itemViewTwo)
		self.dateLabel.text = "Github since \(user.createdAt.converToMonthYearFormat())"
	}
	
	// -- layout
	func layoutUI() {
		
		let padding: CGFloat = 20
		let itemHeight: CGFloat = 140
		
		itemViews = [headerView, itemViewOne, itemViewTwo, dateLabel]
		
		for itemView in itemViews {
			contentView.addSubview(itemView)
			itemView.translatesAutoresizingMaskIntoConstraints = false
			
			NSLayoutConstraint.activate([
				itemView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
				itemView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding)
			])
		}
		
		NSLayoutConstraint.activate([
			headerView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
			headerView.heightAnchor.constraint(equalToConstant: 210),
			
			itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
			itemViewOne.heightAnchor.constraint(equalToConstant: itemHeight),
			
			itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: padding),
			itemViewTwo.heightAnchor.constraint(equalToConstant: itemHeight),
			
			dateLabel.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor, constant: padding),
			dateLabel.heightAnchor.constraint(equalToConstant: 50)
		])
	}
	
	// -- helper
	func add(childVC: UIViewController, to containerView: UIView) {
		addChild(childVC)
		containerView.addSubview(childVC.view)
		childVC.view.frame = containerView.bounds
		childVC.didMove(toParent: self)
	}
	
	// -- dismiss the view controller
	@objc func dismissVC() {
		dismiss(animated: true)
	}
}


extension UserInfoVC: GFRepoItemVCDelegate {
	// -- what to do on github button
	func didTapGithubProfile(for user: UserModel) {
		guard let url = URL(string: user.htmlUrl) else {
			presentGFAlert(
				title: "Invalid URL",
				message: "The URL attached to this user is invalid",
				buttonTitle: "OK"
			)
			return
		}
		
		presentSafariVC(with: url)
	}
}

extension UserInfoVC: GFFollowerItemVCDelegate {
	
	func didTapGetFollowers(for user: UserModel) {
		guard user.followers != 0 else {
			presentGFAlert(
				title: "No followers",
				message: "This user has no followers",
				buttonTitle: "So sad"
			)
			return
		}
		delegate.didRequestFollowers(for: user.login)
		dismissVC()
	}
}

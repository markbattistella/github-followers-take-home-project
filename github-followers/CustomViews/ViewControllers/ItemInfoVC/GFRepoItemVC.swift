//
//  GFRepoItemVC.swift
//  github-followers
//
//  Created by Mark Battistella on 9/10/21.
//

import UIKit

protocol GFRepoItemVCDelegate: AnyObject {
	func didTapGithubProfile(for user: UserModel)
}

class GFRepoItemVC: GFItemInfoVC {
	
	weak var delegate: GFRepoItemVCDelegate!
	
	init(user: UserModel, delegate: GFRepoItemVCDelegate) {
		super.init(user: user)
		self.delegate = delegate
	}
	
	required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
	
	// what override from default
	override func viewDidLoad() {
		super.viewDidLoad()
		configure()
	}
	
	//
	private func configure() {
		itemInfoViewOne.set(itemInfoType: .repo, with: user.publicRepos)
		itemInfoViewTwo.set(itemInfoType: .gists, with: user.publicGists)
		actionButton.set(backgroundColour: .systemPurple, title: "GitHub Profile")
	}
	
	override func actionButtonTapped() {
		delegate.didTapGithubProfile(for: user)
	}
}

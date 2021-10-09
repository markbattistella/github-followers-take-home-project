//
//  GFRepoItemVC.swift
//  github-followers
//
//  Created by Mark Battistella on 9/10/21.
//

import UIKit

class GFRepoItemVC: GFItemInfoVC {
	
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

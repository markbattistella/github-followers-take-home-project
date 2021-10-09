//
//  GFFollowerItemVC.swift
//  github-followers
//
//  Created by Mark Battistella on 9/10/21.
//

import UIKit

class GFFollowerItemVC: GFItemInfoVC {
	
	// what override from default
	override func viewDidLoad() {
		super.viewDidLoad()
		configure()
	}
	
	//
	private func configure() {
		itemInfoViewOne.set(itemInfoType: .followers, with: user.followers)
		itemInfoViewTwo.set(itemInfoType: .following, with: user.following)
		actionButton.set(backgroundColour: .systemGreen, title: "Get followers")
	}
	
	override func actionButtonTapped() {
		delegate.didTapGetFollowers(for: user)
	}
}

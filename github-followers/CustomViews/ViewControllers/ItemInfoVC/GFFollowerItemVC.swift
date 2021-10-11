//
//  GFFollowerItemVC.swift
//  github-followers
//
//  Created by Mark Battistella on 9/10/21.
//

import UIKit

protocol GFFollowerItemVCDelegate: AnyObject {
	func didTapGetFollowers(for user: UserModel)
}

class GFFollowerItemVC: GFItemInfoVC {
	
	weak var delegate: GFFollowerItemVCDelegate!
	
	init(user: UserModel, delegate: GFFollowerItemVCDelegate) {
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
		itemInfoViewOne.set(itemInfoType: .followers, with: user.followers)
		itemInfoViewTwo.set(itemInfoType: .following, with: user.following)
		actionButton.set(colour: .systemGreen, title: "Get followers")
	}
	
	override func actionButtonTapped() {
		delegate.didTapGetFollowers(for: user)
	}
}

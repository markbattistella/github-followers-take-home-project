//
//  FollowerCell.swift
//  github-followers
//
//  Created by Mark Battistella on 7/10/21.
//

import UIKit

class FollowerCell: UICollectionViewCell {
	
    static let resuseID = "FollowerCell"
	let avatarImageView = GFAvatarImageView(frame: .zero)
	let usernameLabel = GFTitleLabel(textAlignment: .center, fontSize: 16)
	
	// what override from default
	override init(frame: CGRect) {
		super.init(frame: frame)
		configure()
	}
	
	// for storyboard
	required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
	
	// set up the cell
	func set(follower: FollowerModel) {
		usernameLabel.text = follower.login
		avatarImageView.downloadAvatarImage(fromUrl: follower.avatarUrl)
	}
	
	// func: default customisation
	private func configure() {
		addSubviews(avatarImageView, usernameLabel)
		
		let padding: CGFloat = 8
		
		NSLayoutConstraint.activate([
			avatarImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: padding),
			avatarImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
			avatarImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
			avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),
			
			usernameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 12),
			usernameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
			usernameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
			usernameLabel.heightAnchor.constraint(equalToConstant: 20)
		])
	}
}

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
		avatarImageView.downloadImage(from: follower.avatarUrl)
	}
	
	// func: default customisation
	private func configure() {
		addSubview(avatarImageView)
		addSubview(usernameLabel)
		
		let padding: CGFloat = 8
		
		NSLayoutConstraint.activate([
			avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
			avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
			avatarImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
			avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),
			
			usernameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 12),
			usernameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
			usernameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
			usernameLabel.heightAnchor.constraint(equalToConstant: 20)
		])
	}
}

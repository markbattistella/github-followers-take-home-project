//
//  FavouriteCell.swift
//  github-followers
//
//  Created by Mark Battistella on 10/10/21.
//

import UIKit

class FavouriteCell: UITableViewCell {
	
	static let resuseID = "FavouriteCell"
	let avatarImageView = GFAvatarImageView(frame: .zero)
	let usernameLabel = GFTitleLabel(textAlignment: .left, fontSize: 26)
	
	// what override from default
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		configure()
	}
	
	// for storyboard
	required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
	
	// set up the cell
	func set(favourite: FollowerModel) {
		usernameLabel.text = favourite.login
		avatarImageView.downloadAvatarImage(fromUrl: favourite.avatarUrl)
	}
	
	// func: default customisation
	private func configure() {
		addSubviews(avatarImageView, usernameLabel)
		accessoryType = .disclosureIndicator
		let padding: CGFloat = 12
		
		NSLayoutConstraint.activate([
			avatarImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
			avatarImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
			avatarImageView.widthAnchor.constraint(equalToConstant: 60),
			avatarImageView.heightAnchor.constraint(equalToConstant: 60),
			
			usernameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
			usernameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 24),
			usernameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
			usernameLabel.heightAnchor.constraint(equalToConstant: 40)
		])
	}
}

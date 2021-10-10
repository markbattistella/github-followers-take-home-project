//
//  GFAvatarImageView.swift
//  github-followers
//
//  Created by Mark Battistella on 7/10/21.
//

import UIKit

class GFAvatarImageView: UIImageView {
	
	let cache = NetworkManager.shared.cache
	let placeholderImage = UIImage(named: "avatar-placeholder")

	// what override from default
	override init(frame: CGRect) {
		super.init(frame: frame)
		configure()
	}
	
	// for storyboard
	required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
	
	// func: default customisation
	private func configure() {
		layer.cornerRadius = 12
		clipsToBounds = true
		image = placeholderImage
		translatesAutoresizingMaskIntoConstraints = false
	}
}

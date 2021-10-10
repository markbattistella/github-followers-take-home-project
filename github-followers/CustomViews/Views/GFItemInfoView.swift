//
//  GFItemInfoView.swift
//  github-followers
//
//  Created by Mark Battistella on 9/10/21.
//

import UIKit

enum ItemInfoType {
	case repo, gists, following, followers
}

class GFItemInfoView: UIView {

	let symbolImageView = UIImageView()
	let titleLabel = GFTitleLabel(textAlignment: .left, fontSize: 14)
	let countLabel = GFTitleLabel(textAlignment: .center, fontSize: 14)
	
	// what override from default
	override init(frame: CGRect) {
		super.init(frame: frame)
		configure()
	}
	
	// for storyboard
	required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
	
	// func: default customisation
	private func configure() {
		addSubviews(symbolImageView, titleLabel, countLabel)
		
		symbolImageView.translatesAutoresizingMaskIntoConstraints = false
		symbolImageView.contentMode = .scaleAspectFill
		symbolImageView.tintColor = .label
		
		NSLayoutConstraint.activate([
			symbolImageView.topAnchor.constraint(equalTo: self.topAnchor),
			symbolImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
			symbolImageView.widthAnchor.constraint(equalToConstant: 20),
			symbolImageView.heightAnchor.constraint(equalToConstant: 20),
			
			titleLabel.centerYAnchor.constraint(equalTo: symbolImageView.centerYAnchor),
			titleLabel.leadingAnchor.constraint(equalTo: symbolImageView.trailingAnchor, constant: 12),
			titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
			titleLabel.heightAnchor.constraint(equalToConstant: 18),
			
			countLabel.topAnchor.constraint(equalTo: symbolImageView.bottomAnchor, constant: 4),
			countLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
			countLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
			countLabel.heightAnchor.constraint(equalToConstant: 18)
		])
	}
	
	// -- change the view on type
	func set(itemInfoType: ItemInfoType, with count: Int) {
		switch itemInfoType {
			case .repo:
				symbolImageView.image = SFSymbols.repo
				titleLabel.text = "Public repos"

			case .gists:
				symbolImageView.image = SFSymbols.gists
				titleLabel.text = "Public gists"

			case .following:
				symbolImageView.image = SFSymbols.following
				titleLabel.text = "Following"

			case .followers:
				symbolImageView.image = SFSymbols.followers
				titleLabel.text = "Followers"
		}

		countLabel.text = String(count)
	}
}

//
//  GFTitleLabel.swift
//  github-followers
//
//  Created by Mark Battistella on 7/10/21.
//

import UIKit

class GFTitleLabel: UILabel {

	// what override from default
	override init(frame: CGRect) {
		super.init(frame: frame)
		configure()
	}
	
	// for storyboard
	required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
	
	// allow customisation
	convenience init(textAlignment: NSTextAlignment, fontSize: CGFloat ) {
		self.init(frame: .zero)
		self.textAlignment = textAlignment
		self.font = UIFont.systemFont(ofSize: fontSize, weight: .bold)
	}

	// func: default customisation
	private func configure() {
		textColor = .label
		adjustsFontSizeToFitWidth = true
		minimumScaleFactor = 0.9
		lineBreakMode = .byTruncatingTail
		translatesAutoresizingMaskIntoConstraints = false
	}
}

//
//  GFTitleLabel.swift
//  github-followers
//
//  Created by Mark Battistella on 7/10/21.
//

import UIKit

class GFTitleLabel: UILabel {

	override init(frame: CGRect) {
		
		// call the super class
		// -- all the defaults
		super.init(frame: frame)
		
		// set our defaults
		configure()
	}
	
	// for storyboard
	required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
	
	// allow customisation
	init(textAlignment: NSTextAlignment, fontSize: CGFloat ) {
		super.init(frame: .zero)
		self.textAlignment = textAlignment
		self.font = UIFont.systemFont(ofSize: fontSize, weight: .bold)
		configure()
	}

	// func: default customisation
	private func configure() {
		textColor = .label
		adjustsFontSizeToFitWidth = true
		minimumScaleFactor = 0.9
		lineBreakMode = .byTruncatingTail
		translatesAutoresizingMaskIntoConstraints = true
	}
}

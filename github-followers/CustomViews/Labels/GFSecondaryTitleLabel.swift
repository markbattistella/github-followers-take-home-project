//
//  GFSecondaryTitleLabel.swift
//  github-followers
//
//  Created by Mark Battistella on 9/10/21.
//

import UIKit

class GFSecondaryTitleLabel: UILabel {
	
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
	convenience init(fontSize: CGFloat) {
		self.init(frame: .zero)
		font = UIFont.systemFont(ofSize: fontSize, weight: .medium)
	}
	
	// func: default customisation
	private func configure() {
		textColor = .secondaryLabel
		adjustsFontSizeToFitWidth = true
		minimumScaleFactor = 0.9
		lineBreakMode = .byTruncatingTail
		translatesAutoresizingMaskIntoConstraints = false
	}
	
}

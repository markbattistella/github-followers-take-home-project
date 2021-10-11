//
//  GFBodyLabel.swift
//  github-followers
//
//  Created by Mark Battistella on 7/10/21.
//

import UIKit

class GFBodyLabel: UILabel {
	
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
	convenience init(textAlignment: NSTextAlignment) {
		self.init(frame: .zero)
		self.textAlignment = textAlignment
	}
	
	// func: default customisation
	private func configure() {
		textColor = .secondaryLabel
		font = UIFont.preferredFont(forTextStyle: .body)
		adjustsFontForContentSizeCategory = true
		adjustsFontSizeToFitWidth = true
		minimumScaleFactor = 0.75
		lineBreakMode = .byWordWrapping
		translatesAutoresizingMaskIntoConstraints = false
	}
}

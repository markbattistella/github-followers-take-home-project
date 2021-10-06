//
//  GFButton.swift
//  github-followers
//
//  Created by Mark Battistella on 6/10/21.
//

import UIKit

class GFButton: UIButton {
	
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
	init(backgroundColour: UIColor, title: String) {
		super.init(frame: .zero)
		self.backgroundColor = backgroundColour
		self.setTitle(title, for: .normal)
		configure()
	}
	
	// func: default customisation
	private func configure() {
		layer.cornerRadius = 10
		titleLabel?.textColor = .white
		titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
		translatesAutoresizingMaskIntoConstraints = false
	}
}

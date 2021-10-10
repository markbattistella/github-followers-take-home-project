//
//  GFButton.swift
//  github-followers
//
//  Created by Mark Battistella on 6/10/21.
//

import UIKit

class GFButton: UIButton {
	
	// what override from default
	override init(frame: CGRect) {
		super.init(frame: frame)
		configure()
	}
	
	// for storyboard
	required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
	
	// allow customisation
	convenience init(backgroundColour: UIColor, title: String) {
		self.init(frame: .zero)
		self.backgroundColor = backgroundColour
		self.setTitle(title, for: .normal)
	}
	
	// func: default customisation
	private func configure() {
		layer.cornerRadius = 10
		setTitleColor(.white, for: .normal)
		titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
		translatesAutoresizingMaskIntoConstraints = false
	}
	
	// set from other views
	func set(backgroundColour: UIColor, title: String) {
		self.backgroundColor = backgroundColour
		setTitle(title, for: .normal)
	}
}

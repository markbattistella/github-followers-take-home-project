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
	convenience init(colour: UIColor, title: String) {
		self.init(frame: .zero)
		set(colour: colour, title: title)
	}
	
	// func: default customisation
	private func configure() {
		configuration = .filled()
		configuration?.cornerStyle = .capsule
		translatesAutoresizingMaskIntoConstraints = false
	}
	
	// set from other views
	final func set(colour: UIColor, title: String) {
		configuration?.baseBackgroundColor = colour
		configuration?.baseForegroundColor = .systemBackground
		configuration?.title = title
		configuration?.imagePadding = 6
		configuration?.imagePlacement = .leading
	}
}

//
//  GFTextField.swift
//  github-followers
//
//  Created by Mark Battistella on 6/10/21.
//

import UIKit

class GFTextField: UITextField {
	
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
	init(placeholder: String) {
		super.init(frame: .zero)
		self.placeholder = placeholder
		configure()
	}
	
	// func: default customisation
	private func configure() {
		translatesAutoresizingMaskIntoConstraints = false
		
		layer.cornerRadius = 10
		layer.borderWidth = 2
		layer.borderColor = UIColor.systemGray4.cgColor
		
		textColor = .label
		tintColor = .label
		textAlignment = .center
		font = UIFont.preferredFont(forTextStyle: .title2)
		adjustsFontSizeToFitWidth = true
		minimumFontSize = 12
		
		backgroundColor = .tertiarySystemBackground
		autocorrectionType = .no
		returnKeyType = .search
	}
}

//
//  GFAlertContainerView.swift
//  github-followers
//
//  Created by Mark Battistella on 10/10/21.
//

import UIKit

class GFAlertContainerView: UIView {

	override init(frame: CGRect) {
		super.init(frame: frame)
		configure()
	}
	
	required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

	private func configure() {
		backgroundColor = .systemBackground
		layer.cornerRadius = 12
		layer.borderWidth = 2
		layer.borderColor = UIColor.white.cgColor
		translatesAutoresizingMaskIntoConstraints = false
	}
}

//
//  UIView+Ext.swift
//  github-followers
//
//  Created by Mark Battistella on 10/10/21.
//

import UIKit

extension UIView {
	
	// -- add all subviews to the view
	func addSubviews(_ views: UIView...) {
		for view in views {
			addSubview(view)
		}
	}
	
	// -- pin constraints to all edges
	func pinToEdges(of superview: UIView) {
		translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			topAnchor.constraint(equalTo: superview.topAnchor),
			leadingAnchor.constraint(equalTo: superview.leadingAnchor),
			trailingAnchor.constraint(equalTo: superview.trailingAnchor),
			bottomAnchor.constraint(equalTo: superview.bottomAnchor)
		])
	}
}

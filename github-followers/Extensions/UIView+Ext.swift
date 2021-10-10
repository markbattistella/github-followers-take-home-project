//
//  UIView+Ext.swift
//  github-followers
//
//  Created by Mark Battistella on 10/10/21.
//

import UIKit

extension UIView {
	
	func addSubviews(_ views: UIView...) {
		for view in views {
			addSubview(view)
		}
	}
}

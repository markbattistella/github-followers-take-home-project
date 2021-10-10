//
//  UITableView+Ext.swift
//  github-followers
//
//  Created by Mark Battistella on 10/10/21.
//

import UIKit

extension UITableView {
	
	func reloadDataOnMainThread() {
		DispatchQueue.main.async {
			self.reloadData()
		}
	}
	
	func removeExcessCells() {
		tableFooterView = UIView(frame: .zero)
	}
}

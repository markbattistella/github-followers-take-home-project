//
//  UIViewController+Ext.swift
//  github-followers
//
//  Created by Mark Battistella on 7/10/21.
//

import UIKit

extension UIViewController {
	func presentGFAlertOnMainThread(title: String, message: String, buttonTitle: String) {
		DispatchQueue.main.async {
			let alertVC = GFAlertVC(title: title, message: message, buttonTitle: buttonTitle)
			alertVC.modalPresentationStyle  = .overFullScreen
			alertVC.modalTransitionStyle    = .crossDissolve
			self.present(alertVC, animated: true)
		}
	}
}

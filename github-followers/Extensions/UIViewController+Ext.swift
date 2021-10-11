//
//  UIViewController+Ext.swift
//  github-followers
//
//  Created by Mark Battistella on 7/10/21.
//

import UIKit
import SafariServices

extension UIViewController {
	
	// -- custom alert
	func presentGFAlert(title: String, message: String, buttonTitle: String) {
		let alertVC = GFAlertVC(title: title, message: message, buttonTitle: buttonTitle)
		alertVC.modalPresentationStyle = .overFullScreen
		alertVC.modalTransitionStyle = .crossDissolve
		self.present(alertVC, animated: true)
	}
	
	func presentDefaultError() {
		let alertVC = GFAlertVC(
			title: "Something went wrong",
			message: "We were unable to perform your task",
			buttonTitle: "Ok"
		)
		alertVC.modalPresentationStyle = .overFullScreen
		alertVC.modalTransitionStyle = .crossDissolve
		self.present(alertVC, animated: true)
	}
	
	// -- show safari
	func presentSafariVC(with url: URL) {
		let safariVC = SFSafariViewController(url: url)
		safariVC.preferredControlTintColor = .systemGreen
		present(safariVC, animated: true)
	}
}

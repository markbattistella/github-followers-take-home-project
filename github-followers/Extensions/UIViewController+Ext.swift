//
//  UIViewController+Ext.swift
//  github-followers
//
//  Created by Mark Battistella on 7/10/21.
//

import UIKit

// fileprivate is globally accessible in this file only
fileprivate var containerView: UIView!

extension UIViewController {

	// custom alert
	func presentGFAlertOnMainThread(title: String, message: String, buttonTitle: String) {
		DispatchQueue.main.async {
			let alertVC = GFAlertVC(title: title, message: message, buttonTitle: buttonTitle)
			alertVC.modalPresentationStyle = .overFullScreen
			alertVC.modalTransitionStyle = .crossDissolve
			self.present(alertVC, animated: true)
		}
	}
	
	// loading state - show
	func showLoadingView() {
		
		// initialise it and fill full screen
		containerView = UIView(frame: view.bounds)
		view.addSubview(containerView)
		
		containerView.backgroundColor = .systemBackground
		containerView.alpha = 0
		
		// animate the background
		UIView.animate(withDuration: 0.25) {
			containerView.alpha = 0.8
		}
		
		// activity indicator
		let activityIndicator = UIActivityIndicatorView(style: .large)
		containerView.addSubview(activityIndicator)
		
		// contraints
		activityIndicator.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
			activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor)
		])
		
		// start the animation
		activityIndicator.startAnimating()
	}
	
	// loading state - remove
	func dismissLoadingView() {
		DispatchQueue.main.async {
			containerView.removeFromSuperview()
			containerView = nil
		}
	}
	
	// show empty results
	func showEmptyStateView(with message: String, in view: UIView) {
		
		// initalise the view
		let emptyStateView = GFEmptyStateView(message: message)
		
		// set to full screen
		emptyStateView.frame = view.bounds
		
		// add it to view
		view.addSubview(emptyStateView)
	}
}

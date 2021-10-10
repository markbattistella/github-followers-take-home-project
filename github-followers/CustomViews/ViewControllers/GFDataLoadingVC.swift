//
//  GFDataLoadingVC.swift
//  github-followers
//
//  Created by Mark Battistella on 10/10/21.
//

import UIKit

class GFDataLoadingVC: UIViewController {

	var containerView: UIView!

	override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
			self.containerView.alpha = 0.8
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
			self.containerView.removeFromSuperview()
			self.containerView = nil
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

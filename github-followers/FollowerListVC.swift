//
//  FollowerListVC.swift
//  github-followers
//
//  Created by Mark Battistella on 6/10/21.
//

import UIKit

class FollowerListVC: UIViewController {
	
	var username: String!

    override func viewDidLoad() {
        super.viewDidLoad()

		view.backgroundColor = .systemBackground
		navigationController?.isNavigationBarHidden = false
		navigationController?.navigationBar.prefersLargeTitles = true
    }
}

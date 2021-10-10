//
//  GFTabBarController.swift
//  github-followers
//
//  Created by Mark Battistella on 10/10/21.
//

import UIKit

class GFTabBarController: UITabBarController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// -- set the colour
		UITabBar.appearance().tintColor = .systemGreen
		
		// -- add the items
		self.viewControllers = [
			createSearchNC(),
			createFavouritesNC()
		]
	}
	
	// create the search nav controller
	func createSearchNC() -> UINavigationController {
		let searchVC = SearchVC()
		
		// -- title
		searchVC.title = "Search"
		
		// -- icon and order
		searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
		
		return UINavigationController(rootViewController: searchVC)
	}
	
	// create the favourite nav controller
	func createFavouritesNC() -> UINavigationController {
		let favouritesListVC = FavouriteListVC()
		
		// -- title
		favouritesListVC.title = "Favourites"
		
		// -- icon and order
		favouritesListVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
		
		return UINavigationController(rootViewController: favouritesListVC)
	}
}

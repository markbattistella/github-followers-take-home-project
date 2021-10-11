//
//  FavouriteListVC.swift
//  github-followers
//
//  Created by Mark Battistella on 6/10/21.
//

import UIKit

class FavouriteListVC: GFDataLoadingVC {
	
	let tableView = UITableView()
	var favourites: [FollowerModel] = []
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		configureViewController()
		configureTableView()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		getFavourites()
	}
	
	//
	private func configureViewController() {
		view.backgroundColor = .systemBackground
		title = "Favourites"
		navigationController?.navigationBar.prefersLargeTitles = true
	}
	
	//
	private func configureTableView() {
		view.addSubview(tableView)
		
		tableView.frame = view.bounds
		tableView.rowHeight = 80
		tableView.delegate = self
		tableView.dataSource = self
		tableView.removeExcessCells()
		
		tableView.register(FavouriteCell.self, forCellReuseIdentifier: FavouriteCell.resuseID)
	}
	
	//
	func getFavourites() {
		PersistenceManager.retrieveFavourites { [weak self] result in
			guard let self = self else { return }

			switch result {
				case .success(let favourites):
					if(favourites.isEmpty) {
						self.showEmptyStateView(with: "No favourites?\nAdd one on the follower screen", in: self.view)
					} else {
						self.favourites = favourites
						DispatchQueue.main.async {
							self.tableView.reloadData()
							self.view.bringSubviewToFront(self.tableView)
						}
					}
					
				case .failure(let error):
					DispatchQueue.main.async {
						self.presentGFAlert(
							title: "Something went wrong",
							message: error.rawValue,
							buttonTitle: "OK"
						)
					}
			}
		}
	}
}


extension FavouriteListVC: UITableViewDataSource, UITableViewDelegate {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return favourites.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: FavouriteCell.resuseID) as! FavouriteCell
		let favourite = favourites[indexPath.row]
		cell.set(favourite: favourite)
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let favourite = favourites[indexPath.row]
		let destVC = FollowerListVC(username: favourite.login)
		navigationController?.pushViewController(destVC, animated: true)
	}

	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		guard editingStyle == .delete else { return }
		PersistenceManager.updateWith(favourite: favourites[indexPath.row], actionType: .remove) { [weak self] error in
			guard let self = self else { return }
			guard let error = error else {
				self.favourites.remove(at: indexPath.row)
				tableView.deleteRows(at: [indexPath], with: .left)
				return
			}
			DispatchQueue.main.async {
				self.presentGFAlert(title: "Unable to remove", message: error.rawValue, buttonTitle: "OK")
			}
		}
	}
}

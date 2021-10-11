//
//  GFItemInfoVC.swift
//  github-followers
//
//  Created by Mark Battistella on 9/10/21.
//

import UIKit

class GFItemInfoVC: UIViewController {
	
	let stackView = UIStackView()
	let itemInfoViewOne = GFItemInfoView()
	let itemInfoViewTwo = GFItemInfoView()
	let actionButton = GFButton()
	
	var user: UserModel!
	
	init(user: UserModel) {
		super.init(nibName: nil, bundle: nil)
		self.user = user
	}
	
	// for storyboard
	required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
	
	// what override from default
	override func viewDidLoad() {
		super.viewDidLoad()
		configureBackgroundView()
		configureStackView()
		configureActionButton()
		layoutUI()
	}
	
	//
	private func configureBackgroundView() {
		view.layer.cornerRadius = 18
		view.backgroundColor = .secondarySystemBackground
	}
	
	//
	private func configureStackView() {
		stackView.axis = .horizontal
		stackView.distribution = .equalSpacing
		
		stackView.addArrangedSubview(itemInfoViewOne)
		stackView.addArrangedSubview(itemInfoViewTwo)
	}
	
	private func configureActionButton() {
		actionButton.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
	}
	
	@objc func actionButtonTapped() {}
	
	//
	private func layoutUI() {
		view.addSubviews(stackView, actionButton)
		
		stackView.translatesAutoresizingMaskIntoConstraints = false
		let padding: CGFloat = 20
		
		NSLayoutConstraint.activate([
			stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
			stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
			stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
			stackView.heightAnchor.constraint(equalToConstant: 50),
			
			actionButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
			actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
			actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
			actionButton.heightAnchor.constraint(equalToConstant: 44)
		])
	}
}

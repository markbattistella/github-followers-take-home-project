//
//  GFUserInfoHeaderVC.swift
//  github-followers
//
//  Created by Mark Battistella on 9/10/21.
//

import UIKit

class GFUserInfoHeaderVC: UIViewController {
	
	let avatarImageView = GFAvatarImageView(frame: .zero)
	let usernameLabel = GFTitleLabel(textAlignment: .left, fontSize: 34)
	let nameLabel = GFSecondaryTitleLabel(fontSize: 18)
	let locationImageView = UIImageView()
	let locationLabel = GFSecondaryTitleLabel(fontSize: 18)
	let bioLabel = GFBodyLabel(textAlignment: .left)
	
	var user: UserModel!
	
	init(user: UserModel) {
		super.init(nibName: nil, bundle: nil)
		self.user = user
	}
	
	// for storyboard
	required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
	
	override func viewDidLoad() {
		super.viewDidLoad()
		addSubViews()
		layoutUI()
		configureUIElements()
	}
	
	//
	func configureUIElements() {
		downloadAvatarImage()
		usernameLabel.text = user.login
		nameLabel.text = user.name ?? ""
		locationLabel.text = user.location ?? "No location"
		bioLabel.text = user.bio ?? ""
		bioLabel.numberOfLines = 3
		locationImageView.image = UIImage(systemName: SFSymbols.location)
		locationImageView.tintColor = .secondaryLabel
	}
	
	func downloadAvatarImage() {
		NetworkManager.shared.downloadImage(from: user.avatarUrl) { [weak self] image in
			guard let self = self else { return }
			DispatchQueue.main.async {
				self.avatarImageView.image = image
			}
		}
	}
	
	//
	func addSubViews() {
		view.addSubview(avatarImageView)
		view.addSubview(usernameLabel)
		view.addSubview(nameLabel)
		view.addSubview(locationImageView)
		view.addSubview(locationLabel)
		view.addSubview(bioLabel)
	}
	
	//
	func layoutUI() {
		let padding: CGFloat = 20
		let textImagePadding: CGFloat = 12
		locationImageView.translatesAutoresizingMaskIntoConstraints = false
		
		// anchors
		NSLayoutConstraint.activate([
			
			// -- image
			avatarImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
			avatarImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			avatarImageView.widthAnchor.constraint(equalToConstant: 90),
			avatarImageView.heightAnchor.constraint(equalToConstant: 90),
			
			// -- username
			usernameLabel.topAnchor.constraint(equalTo: avatarImageView.topAnchor),
			usernameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
			usernameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			usernameLabel.heightAnchor.constraint(equalToConstant: 38),
			
			// -- name
			nameLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor, constant: 8),
			nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
			nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			nameLabel.heightAnchor.constraint(equalToConstant: 20),
			
			// -- location image
			locationImageView.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor),
			locationImageView.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
			locationImageView.widthAnchor.constraint(equalToConstant: 20),
			locationImageView.heightAnchor.constraint(equalToConstant: 20),
			
			// -- location
			locationLabel.centerYAnchor.constraint(equalTo: locationImageView.centerYAnchor),
			locationLabel.leadingAnchor.constraint(equalTo: locationImageView.trailingAnchor, constant: 5),
			locationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			locationLabel.heightAnchor.constraint(equalToConstant: 20),
			
			// -- bio
			bioLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: textImagePadding),
			bioLabel.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor),
			bioLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			bioLabel.heightAnchor.constraint(equalToConstant: 60)
		])
	}
}

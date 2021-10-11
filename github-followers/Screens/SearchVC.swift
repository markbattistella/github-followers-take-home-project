//
//  SearchVC.swift
//  github-followers
//
//  Created by Mark Battistella on 6/10/21.
//

import UIKit

class SearchVC: UIViewController {
	
	let logoImageView = UIImageView()
	let usernameTextField = GFTextField(placeholder: "Enter a username")
	let callToActionButton = GFButton(colour: .systemGreen, title: "Get followers")
	var isUsernameEntered: Bool {
		return !usernameTextField.text!.isEmpty
	}
	
	
	// -- only first run
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .systemBackground
		view.addSubviews(logoImageView, usernameTextField, callToActionButton)
		
		configureLogoImageView()
		configureTextField()
		configureCallToActionButton()
		createDismissKeyboardTapGesture()
	}
	
	// -- everytime it shows
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		usernameTextField.text = ""
		navigationController?.setNavigationBarHidden(false, animated: true)
	}
	
	
	// MARK: - keyboard
	func createDismissKeyboardTapGesture() {
		let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
		view.addGestureRecognizer(tap)
	}
	
	// method: call when submitting form
	@objc func pushFollowerListVC() {
		
		// check if field is empty
		guard isUsernameEntered else {
			
			presentGFAlert(
				title: "Empty username field",
				message: "Please enter a username in the field so we know who to search for",
				buttonTitle: "OK"
			)
			return
		}
		
		// drop the keyboards
		usernameTextField.resignFirstResponder()
		
		// view to go to
		let followerListVC = FollowerListVC(username: usernameTextField.text!)
		
		// add to stack
		navigationController?.pushViewController(followerListVC, animated: true)
	}
	
	// MARK: - interface setup
	func configureLogoImageView() {
		logoImageView.translatesAutoresizingMaskIntoConstraints = false
		logoImageView.image = Images.ghLogo
		
		let topConstraintConstant: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? 20 : 80
		
		// constraints
		// -- activate the constraints
		NSLayoutConstraint.activate([
			
			// -- y cord
			logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: topConstraintConstant),
			
			// -- x cord
			logoImageView.centerXAnchor.constraint(
				equalTo: view.centerXAnchor
			),
			
			// -- height
			logoImageView.heightAnchor.constraint(
				equalToConstant: 200
			),
			
			// -- width
			logoImageView.widthAnchor.constraint(
				equalToConstant: 200
			)
		])
	}
	
	func configureTextField() {
		// set the delegate
		usernameTextField.delegate = self
		
		// constraints
		// -- activate the constraints
		NSLayoutConstraint.activate([
			usernameTextField.topAnchor.constraint(
				equalTo: logoImageView.bottomAnchor,
				constant: 48
			),
			usernameTextField.leadingAnchor.constraint(
				equalTo: view.leadingAnchor,
				constant: 50
			),
			usernameTextField.trailingAnchor.constraint(
				equalTo: view.trailingAnchor,
				constant: -50
			),
			usernameTextField.heightAnchor.constraint(
				equalToConstant: 50
			)
		])
	}
	
	func configureCallToActionButton() {
		callToActionButton.addTarget(self, action: #selector(pushFollowerListVC), for: .touchUpInside)
		
		// constraints
		// -- activate the constraints
		NSLayoutConstraint.activate([
			callToActionButton.bottomAnchor.constraint(
				equalTo: view.safeAreaLayoutGuide.bottomAnchor,
				constant: -50
			),
			callToActionButton.leadingAnchor.constraint(
				equalTo: view.leadingAnchor,
				constant: 50
			),
			callToActionButton.trailingAnchor.constraint(
				equalTo: view.trailingAnchor,
				constant: -50
			),
			callToActionButton.heightAnchor.constraint(
				equalToConstant: 50
			)
		])
	}
}

extension SearchVC: UITextFieldDelegate {
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		
		pushFollowerListVC()
		
		return true
	}
}

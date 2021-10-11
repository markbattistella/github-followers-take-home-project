//
//  UserModel.swift
//  github-followers
//
//  Created by Mark Battistella on 7/10/21.
//

import Foundation

struct UserModel: Decodable {
	let login: String
	let avatarUrl: String
	var name: String?
	var location: String?
	var bio: String?
	let publicRepos: Int
	let publicGists: Int
	let htmlUrl: String
	let followers: Int
	let following: Int
	let createdAt: Date
}

//
//  FollowerModel.swift
//  github-followers
//
//  Created by Mark Battistella on 7/10/21.
//

import Foundation

struct FollowerModel: Decodable, Hashable {
	let login: String
	let avatarUrl: String
}

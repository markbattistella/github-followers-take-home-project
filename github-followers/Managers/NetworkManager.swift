//
//  NetworkManager.swift
//  github-followers
//
//  Created by Mark Battistella on 7/10/21.
//

import UIKit

final class NetworkManager {
	
	// singleton
	static let shared = NetworkManager()
	private let baseUrl = "https://api.github.com/users/"
	let cache = NSCache<NSString, UIImage>()
	let decoder = JSONDecoder()
	
	private init() {
		// convert from snake to camel case
		decoder.keyDecodingStrategy = .convertFromSnakeCase
		
		// recognise date standard
		decoder.dateDecodingStrategy = .iso8601
	}
	
	// MARK: - get the searched user followers
	func getFollowers(for username: String, page: Int) async throws -> [FollowerModel] {
		let endpoint = baseUrl + "\(username)/followers?per_page=100&page=\(page)"
		
		// -- valid url
		guard let url = URL(string: endpoint) else {
			throw GFError.invalidUsername
		}
		
		// -- build the session
		let (data, response) = try await URLSession.shared.data(from: url)
		
		// -- response
		guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
			throw GFError.invalidResponse
		}
		
		// -- working
		do {
			return try decoder.decode([FollowerModel].self, from: data)
		} catch {
			throw GFError.invalidData
		}
	}
	
	// MARK: - get the searched user data
	func getUserInfo(for username: String) async throws -> UserModel {
		
		let endpoint = baseUrl + "\(username)"
		
		// -- valid url
		guard let url = URL(string: endpoint) else {
			throw GFError.invalidUsername
		}
		
		// -- build the session
		let (data, response) = try await URLSession.shared.data(from: url)
		
		// -- response
		guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
			throw GFError.invalidResponse
		}
		
		// -- working
		do {
			return try decoder.decode(UserModel.self, from: data)
		} catch {
			throw GFError.invalidData
		}
	}
	
	// MARK: - download the user profile image
	func downloadImage(from urlString: String) async -> UIImage? {

		// -- convert string to nsstring
		let cacheKey = NSString(string: urlString)
		
		// -- check the cache for the image based on key
		if let image = cache.object(forKey: cacheKey) { return image }
		
		// -- normal network call for url
		guard let url = URL(string: urlString) else { return nil }
		
		// -- working
		do {
			let (data, _) = try await URLSession.shared.data(from: url)
			guard let image = UIImage(data: data) else { return nil }
			cache.setObject(image, forKey: cacheKey)
			return image
		} catch {
			return nil
		}
	}
}

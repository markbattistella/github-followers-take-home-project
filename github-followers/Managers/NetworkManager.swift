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
	private init() {}
	
	private let baseUrl = "https://api.github.com/users/"
	let cache = NSCache<NSString, UIImage>()

	// MARK: - get the searched user followers
	func getFollowers(for username: String, page: Int, completed: @escaping (Result<[FollowerModel], GFError>) -> Void) {
		
		let endpoint = baseUrl + "\(username)/followers?per_page=100&page=\(page)"
		
		// -- valid url
		guard let url = URL(string: endpoint) else {
			completed(.failure(.invalidUsername))
			return
		}
		
		// -- build the session
		let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
			
			// -- error
			if let _ = error {
				completed(.failure(.unableToComplete))
				return
			}
			
			// -- response
			guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
				completed(.failure(.invalidResponse))
				return
			}
			
			// -- data
			guard let data = data else {
				completed(.failure(.invalidData))
				return
			}
			
			// -- working
			do {
				let decoder = JSONDecoder()
				
				// convert from snake to camel case
				decoder.keyDecodingStrategy = .convertFromSnakeCase
				
				let followers = try decoder.decode([FollowerModel].self, from: data)
				
				completed(.success(followers))
				
			} catch {
				completed(.failure(.invalidData))
			}
		}
		
		// -- start the data fetch
		task.resume()
	}
}

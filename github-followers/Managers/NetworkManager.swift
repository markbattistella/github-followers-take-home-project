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


	// MARK: - get the searched user data
	func getUserInfo(for username: String, completed: @escaping (Result<UserModel, GFError>) -> Void) {
		
		let endpoint = baseUrl + "\(username)"
		
		// -- valid url
		guard let url = URL(string: endpoint) else {
			completed(.failure(.invalidUsername))
			return
		}
		
		// -- build the session
		let task = URLSession.shared.dataTask(with: url) { data, response, error in
			
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
				
				// recognise date standard
				decoder.dateDecodingStrategy = .iso8601
				
				let user = try decoder.decode(UserModel.self, from: data)
				
				completed(.success(user))
				
			} catch {
				completed(.failure(.invalidData))
			}
		}
		
		// -- start the data fetch
		task.resume()
	}
	
	//
	func downloadImage(from urlString: String, completed: @escaping (UIImage?) -> Void) {
		// -- convert string to nsstring
		let cacheKey = NSString(string: urlString)
		
		// -- check the cache for the image based on key
		if let image = cache.object(forKey: cacheKey) {
			completed(image)
			return
		}
		
		// -- download if not in cache
		
		// -- normal network call for url
		guard let url = URL(string: urlString) else {
			completed(nil)
			return
		}
		
		let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
			
			// for ARC - [weak self]
			guard let self = self,
				  error == nil,
				  let response = response as? HTTPURLResponse, response.statusCode == 200,
				  let data = data,
				  let image = UIImage(data: data) else {
					  completed(nil)
					  return
				  }

			// cache the image
			self.cache.setObject(image, forKey: cacheKey)
			completed(image)
		}
		task.resume()
	}
}

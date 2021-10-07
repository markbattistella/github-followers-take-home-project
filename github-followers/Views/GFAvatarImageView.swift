//
//  GFAvatarImageView.swift
//  github-followers
//
//  Created by Mark Battistella on 7/10/21.
//

import UIKit

class GFAvatarImageView: UIImageView {
	
	let cache = NetworkManager.shared.cache
	let placeholderImage = UIImage(named: "avatar-placeholder")

	// what override from default
	override init(frame: CGRect) {
		super.init(frame: frame)
		configure()
	}
	
	// for storyboard
	required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
	
	// func: default customisation
	private func configure() {
		layer.cornerRadius = 12
		clipsToBounds = true
		image = placeholderImage
		translatesAutoresizingMaskIntoConstraints = false
	}
	
	//
	func downloadImage(from urlString: String) {
		
		// -- convert string to nsstring
		let cacheKey = NSString(string: urlString)
		
		// -- check the cache for the image based on key
		if let image = cache.object(forKey: cacheKey) {
			self.image = image
			return
		}
		
		// -- download if not in cache
		
		// -- normal network call for url
		guard let url = URL(string: urlString) else { return }
		
		let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
			
			// for ARC - [weak self]
			guard let self = self else { return }
			
			// exit if any error
			if error != nil { return }
			guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return	}
			guard let data = data else { return	}
			
			// unwrap image data
			guard let image = UIImage(data: data) else { return }
			
			// cache the image
			self.cache.setObject(image, forKey: cacheKey)
			
			// main thread for ui update
			DispatchQueue.main.async {
				self.image = image
			}
		}
		task.resume()
	}
}

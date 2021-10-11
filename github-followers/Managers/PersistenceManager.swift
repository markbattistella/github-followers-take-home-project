//
//  PersistenceManager.swift
//  github-followers
//
//  Created by Mark Battistella on 10/10/21.
//

import Foundation

// create some functionality types
enum PersistenceActionType {
	case add, remove
}

enum PersistenceManager {
	static private let defaults = UserDefaults.standard
	
	// user defaults key
	enum Keys { static let favourites = "favourites" }
	
	// updating the saved data
	static func updateWith(
		favourite: FollowerModel,
		actionType: PersistenceActionType,
		completed: @escaping (GFError?) -> Void
	) {
		// -- call the function
		retrieveFavourites { result in
			
			// -- switch the result
			switch result {
				case .success(var favourites):
					
					// swtich on action
					switch actionType {
						case .add:
							
							// stop adding existing data
							guard !favourites.contains(favourite) else {
								completed(.alreadyInFavourites)
								return
							}
							
							// add the item to the array
							favourites.append(favourite)
							
						case .remove:
							
							// find all matches and remove
							favourites.removeAll { $0.login == favourite.login }
					}
					
					// save the data to the user defaults
					completed(save(favourites: favourites))
					
				case .failure(let error):
					completed(error)
			}
		}
	}
	
	// MARK: - user defaults GET / DELETE
	// -- get the data saved
	static func retrieveFavourites(completed: @escaping (Result<[FollowerModel], GFError>) -> Void) {
		
		// if there are none set empty array
		guard let favouritesData = defaults.object(forKey: Keys.favourites) as? Data else {
			completed(.success([]))
			return
		}
		
		do {
			let decoder = JSONDecoder()
			let favourites = try decoder.decode([FollowerModel].self, from: favouritesData)
			completed(.success(favourites))
		} catch {
			completed(.failure(.unableToFavourite))
		}
	}
	
	// -- save the favourite
	static func save(favourites: [FollowerModel]) -> GFError? {
		do {
			let encoder = JSONEncoder()
			let encodedFavourites = try encoder.encode(favourites)
			defaults.set(encodedFavourites, forKey: Keys.favourites)
			return nil
		} catch {
			return .unableToFavourite
		}
	}
}

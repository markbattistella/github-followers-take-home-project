//
//  GFError.swift
//  github-followers
//
//  Created by Mark Battistella on 7/10/21.
//

import Foundation

enum GFError: String, Error {
	
	case invalidUsername = "This username creates and invalid request"
	case unableToComplete = "Unable to complete your rquest. Please check your internet connection"
	case invalidResponse = "Invalid response from the server"
	case invalidData = "The data received from the server is invalid"
	case unableToFavourite = "There was an error saving this user to favourites"
	case alreadyInFavourites = "You've already favourited this user"
}

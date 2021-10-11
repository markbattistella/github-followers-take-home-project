//
//  String+Ext.swift
//  github-followers
//
//  Created by Mark Battistella on 10/10/21.
//

import Foundation

extension String {
	
	// func: convert from UTC string to Date object
	func convertUTCToDate() -> Date? {
		
		// -- formatter
		let dateFormatter = DateFormatter()
		
		// -- what is the current format
		dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
		
		// -- where are we
		dateFormatter.locale = Locale(identifier: "en_AU")
		
		// -- timezome current system
		dateFormatter.timeZone = .current
		
		// -- output
		return dateFormatter.date(from: self)
	}
	
	// func: convert the json data to formatted string
	func convertToDisplayFormat() -> String {
		guard let date = self.convertUTCToDate() else { return "" }
		return date.converToMonthYearFormat()
	}
}

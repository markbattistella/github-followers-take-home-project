//
//  Date+Ext.swift
//  github-followers
//
//  Created by Mark Battistella on 10/10/21.
//

import Foundation

extension Date {
	
	// func: output date into MMM YYYY
	func converToMonthYearFormat() -> String {
		
		// -- formatter
		let dateFormatter = DateFormatter()
		
		// -- what is the current format
		dateFormatter.dateFormat = "MMM yyyy"
		
		// -- output
		return dateFormatter.string(from: self)
	}
}

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
		return formatted(.dateTime.month().year())
	}
}

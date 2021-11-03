//
//  Date+Ext.swift
//  Github Followers
//
//  Created by Abdirizak Hassan on 11/3/21.
//

import Foundation


extension Date {
    func convertToMonthYearFormat() -> String {
        let dateFormartter = DateFormatter()
        dateFormartter.dateFormat = "MMM yyyy"
        return dateFormartter.string(from: self)
    }
}

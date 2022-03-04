//
//  DateHelper.swift
//  YourReading
//
//  Created by Yi An Chen on 2022/2/21.
//

import Foundation

extension Date {
    func toString(format: String = "yyyy-MM-dd") -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
}

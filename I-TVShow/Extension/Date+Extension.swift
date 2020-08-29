//
//  Date+Extension.swift
//  I-TVShow
//
//  Created by Fuego on 8/29/20.
//  Copyright © 2020 Kobi Cook. All rights reserved.
//

import Foundation

//file private formatter struct to avoid continous creation of the date formatter and wasting resources
fileprivate struct Formatter{
    static func formatDate(with time: Bool) -> DateFormatter {
        let formatter = DateFormatter()
        
        if time {
            formatter.dateFormat = "yyyy/MM/dd"
        } else {
            formatter.dateStyle = .medium
            formatter.timeStyle = .none
        }
        
        return formatter
    }
}

extension Date {
    
    //Diff in days - gets difference in days between date given and today, not including today in the total calculation.
    var diffInDays: Int? {
        let now = Calendar.current.dateComponents(in: .current, from: Date())
        let yesterday = DateComponents(year: now.year, month: now.month, day: now.day! - 1)
        let dateYesterday = Calendar.current.date(from: yesterday)!
        let then = self
        let calendar = Calendar.current
        return calendar.dateComponents([.day], from: then, to: dateYesterday).day
    }
    
    init?(fromString: String, with time: Bool = true) {
        let formatter = Formatter.formatDate(with: time)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        guard let date = formatter.date(from: fromString) else { return nil}
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour], from: date)
        let finalDate = calendar.date(from: components)
        self = finalDate!
    }
}

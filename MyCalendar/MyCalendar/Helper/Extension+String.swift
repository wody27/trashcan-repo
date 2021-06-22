//
//  File.swift
//  MyCalendar
//
//  Created by 이재용 on 2021/06/21.
//

import Foundation

extension String {
    static var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    var date: Date? {
        return String.dateFormatter.date(from: self)
    }
}

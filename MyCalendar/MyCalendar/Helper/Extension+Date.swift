//
//  Extension+Date.swift
//  MyCalendar
//
//  Created by 이재용 on 2021/06/21.
//

import Foundation

extension Date {
    
    var weekday: Int {
        get {
            Calendar.current.component(.weekday, from: self)
        }
    }
    
    var firstDayOfTheMonth: Date {
        get {
            Calendar.current.date(from: Calendar.current.dateComponents([.year,.month], from: self))!
        }
    }
}

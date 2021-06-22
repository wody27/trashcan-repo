//
//  ContentMonthView.swift
//  MyCalendar
//
//  Created by 이재용 on 2021/06/23.
//

import UIKit

class ContentMonthView: UIView, UIScrollViewDelegate {
    
    let previous = "previous"
    let presented = "presented"
    let following = "following"
    
    var calendarViews: [CalendarView]? {
        didSet {
            addFirstAndLastCalendar()
        }
    }
    
    var _calendarViews: [CalendarView]? {
        didSet {
            updateContentView()
        }
    }
    
    lazy var contentScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsHorizontalScrollIndicator = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.isPagingEnabled = true
        scrollView.isScrollEnabled = true
        scrollView.delegate = self
        return scrollView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureAll()
    }
    
    private func configureAll() {
        contentScrollView.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height)
        addSubview(contentScrollView)
    }
    
    private func addFirstAndLastCalendar() {
        guard let tempCalendar = calendarViews else {
            _calendarViews = calendarViews
            return
        }
    }
    
    private func updateContentView() {
        
    }
    
    lazy var calendarView: CalendarView = {
        var calendar = CalendarView(month: currentMonth, year: currentYear)
        calendar.translatesAutoresizingMaskIntoConstraints = false
        return calendar
    }()
    
    
    
    // MARK: - Computed Property
    
    var currentYear: Int {
        get {
            Calendar.current.component(.year, from: Date())
        }
    }
    
    var currentMonth: Int {
        get {
            Calendar.current.component(.month, from: Date())
        }
    }
    
    var currentDate: Int {
        get {
            Calendar.current.component(.day, from: Date())
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

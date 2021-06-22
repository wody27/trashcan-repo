//
//  ViewController.swift
//  MyCalendar
//
//  Created by 이재용 on 2021/06/21.
//

import UIKit

public typealias Identifier = String

class ViewController: UIViewController, UIScrollViewDelegate {
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureAll()
    }

    
    private func configureAll() {
        setUpScrollView()
        
    }
    
    private func setUpScrollView() {
        view.addSubview(contentCalendarView)
        contentCalendarView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        contentCalendarView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        contentCalendarView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        contentCalendarView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    }
    

 
    let contentCalendarView: ContentMonthView = {
        let content = ContentMonthView()
        content.translatesAutoresizingMaskIntoConstraints = false
        return content
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
    
}


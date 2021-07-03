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
        view.addSubview(calendarView)
        calendarView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        calendarView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        calendarView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        calendarView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    }
    
    lazy var calendarView: CalendarView = {
        let calendar = CalendarView(frame: self.view.frame)
        calendar.translatesAutoresizingMaskIntoConstraints = false
        return calendar
    }()

}


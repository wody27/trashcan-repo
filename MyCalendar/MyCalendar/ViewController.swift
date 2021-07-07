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
        print("HELO")
        
    }
    
    private func setUpScrollView() {
        view.addSubview(calendarView)
        calendarView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        calendarView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        calendarView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        calendarView.heightAnchor.constraint(equalToConstant: view.frame.height - 150).isActive = true
        
        view.addSubview(button)
        button.topAnchor.constraint(equalTo: calendarView.bottomAnchor, constant: 50).isActive = true
        button.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        button.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
    lazy var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Change", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(change), for: .touchUpInside)
        return button
    }()
    
    lazy var calendarView: CalendarView = {
        let calendar = CalendarView(frame: self.view.frame)
        calendar.translatesAutoresizingMaskIntoConstraints = false
        return calendar
    }()

    @IBAction func change(_ sender: Any) {
        print("DFHIDS")
        calendarView.changeCalendarMode()
    }
    
}


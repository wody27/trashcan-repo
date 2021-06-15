//
//  ViewController.swift
//  CalendarTutorial
//
//  Created by 이재용 on 2021/04/15.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - 변수들
    
    //MARK: - 상수들
    let calendarView: CalendarView = {
        let v = CalendarView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Calendar"
        self.navigationController?.navigationBar.isTranslucent = false
        self.view.backgroundColor = Style.bgColor
//        self.view.addSubview(calendarView)
//        calendarView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
//        calendarView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -12).isActive = true
//        calendarView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 12).isActive = true
//        calendarView.heightAnchor.constraint(equalToConstant: 400).isActive = true
        
    }
}


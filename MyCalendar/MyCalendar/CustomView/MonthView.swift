//
//  MonthView.swift
//  MyCalendar
//
//  Created by 이재용 on 2021/06/22.
//

import UIKit

class MonthView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureAll()
        
        presentedYear = Calendar.current.component(.year, from: Date())
        presentedMonth = Calendar.current.component(.month, from: Date())
    }
    
    @objc private func btnLeftRightAction(sender: UIButton) {
        var nextMonth: Int  = 0
        var nextYear: Int   = 0
        if sender == btnLeft {
            if presentedMonth < 2 {
                nextMonth = 12
                nextYear = presentedYear - 1
            } else {
                nextMonth = presentedMonth - 1
                nextYear = presentedYear
            }
        } else {
            if presentedMonth > 11 {
                nextMonth = 1
                nextYear = presentedYear + 1
            } else {
                nextMonth = presentedMonth + 1
                nextYear = presentedYear
            }
        }
        presentedMonth = nextMonth
        presentedYear = nextYear
        yearAndMonth = "\(nextYear).\(nextMonth)"
//        delegate?.didChangeMonth(month: nextMonth, year: nextYear)
    }
    
    private func configureAll() {
        
        setUpViews()
    }
    
    private func setUpViews() {
        addSubview(monthLabel)
        monthLabel.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        monthLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        monthLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 28).isActive = true
        monthLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        monthLabel.text = "2021.06"
        
        addSubview(btnLeft)
        btnLeft.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        btnLeft.leftAnchor.constraint(equalTo: monthLabel.rightAnchor, constant: 10).isActive = true
        btnLeft.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        addSubview(btnRight)
        btnRight.topAnchor.constraint(equalTo: topAnchor).isActive = true
        btnRight.leftAnchor.constraint(equalTo: btnLeft.rightAnchor, constant: 10).isActive = true
        btnRight.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    func updateYearAndMonth(to date: MyDateExpression) {
        let year = date.year
        let month = date.month
        yearAndMonth = "\(year).\(month)"
    }
    
    // MARK: - Property
    var yearAndMonth: String = "0000.00" {
        didSet {
            let year = yearAndMonth.split(separator: ".")[0]
            var month = yearAndMonth.split(separator: ".")[1]
            if Int(month)! < 10 {
                month = "0" + month
            }
            yearAndMonth = String(year + "." + month)
            monthLabel.text = yearAndMonth
        }
    }
    
    var presentedMonth: Int = 0
    var presentedYear: Int  = 0
    
    // MARK: - Views
    
    var monthLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = UIColor.black
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let btnRight: UIButton = {
        let btn=UIButton()
        btn.setTitle(">", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints=false
        btn.addTarget(self, action: #selector(btnLeftRightAction(sender:)), for: .touchUpInside)
        return btn
    }()
    
    let btnLeft: UIButton = {
        let btn=UIButton()
        btn.setTitle("<", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints=false
        btn.addTarget(self, action: #selector(btnLeftRightAction(sender:)), for: .touchUpInside)
        btn.setTitleColor(UIColor.lightGray, for: .disabled)
        return btn
    }()
    
    required init?(coder: NSCoder) {
        fatalError("DO Not Use on Storyboard")
    }
    
    
}

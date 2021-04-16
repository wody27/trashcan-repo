//
//  MonthView.swift
//  CalendarTutorial
//
//  Created by 이재용 on 2021/04/15.
//

import UIKit

protocol MonthViewDelegate: class {
    func didChangeMonth(monthIndex: Int, year: Int)
}

extension MonthViewDelegate {
    func didChangeMonth(monthIndex: Int, year: Int) {}
}

class MonthView: UIView {
    
    //MARK: - 변수선언
    var monthsArray = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    var currentMonthIndex = 0
    var currentYear: Int = 0
    var delegate: MonthViewDelegate?
    
    let labelName: UILabel = {
        let label = UILabel()
        label.text = "Default Month Year text"
        label.textColor = Style.monthViewLabelColor
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let buttonRight: UIButton = {
        let button = UIButton()
        button.setTitle(">", for: .normal)
        button.setTitleColor(Style.monthViewButtonRightColor, for: .normal)
        button.addTarget(self, action: #selector(buttonLeftRightAction(sender:)), for: .touchUpInside)
        return button
    }()
    
    let buttonLeft: UIButton = {
        let button = UIButton()
        button.setTitle("<", for: .normal)
        button.setTitleColor(Style.monthViewButtonRightColor, for: .normal)
        button.addTarget(self, action: #selector(buttonLeftRightAction(sender:)), for: .touchUpInside)
        return button
    }()
    
    @objc func buttonLeftRightAction(sender: UIButton) {
        if sender == buttonRight {
            currentMonthIndex += 1
            if currentMonthIndex > 11 {
                currentMonthIndex = 0
                currentYear += 1
            } else {
                currentMonthIndex -= 1
                if currentMonthIndex < 0 {
                    currentMonthIndex = 11
                    currentYear -= 1
                }
            }
        }
        labelName.text = "\(currentYear).\(monthsArray[currentMonthIndex-1])"
        delegate?.didChangeMonth(monthIndex: currentMonthIndex, year: currentYear)
    }
    
    //MARK: - private 함수
    private func setupViews() {
        self.addSubview(labelName)
        labelName.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        labelName.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        labelName.widthAnchor.constraint(equalToConstant: 150).isActive = true
        labelName.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        labelName.text = "\(currentYear).\(monthsArray[currentMonthIndex-1])"
        self.addSubview(buttonRight)
        buttonRight.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        buttonRight.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        buttonRight.widthAnchor.constraint(equalToConstant: 50).isActive = true
        buttonRight.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        self.addSubview(buttonLeft)
        buttonLeft.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        buttonLeft.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        buttonLeft.widthAnchor.constraint(equalToConstant: 50).isActive = true
        buttonLeft.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        print   ("MonthView SubViews Add")
    }
    
    //MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        
        currentMonthIndex = Calendar.current.component(.month, from: Date())
        currentYear = Calendar.current.component(.year, from: Date())
        
        print("MonthView init")
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

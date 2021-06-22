//
//  WeekdayCVCell.swift
//  MyCalendar
//
//  Created by 이재용 on 2021/06/22.
//

import UIKit

class WeekdayCVCell: UICollectionViewCell {
    static let identifier: String = "WeekdayCVCell"
    
    // MARK: - Views
    let weekdayLabel: UILabel = {
        var label = UILabel()
        label.text = "MON"
        label.textAlignment = .center
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 10)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpView()
    }
    
    private func setUpView() {
        addSubview(weekdayLabel)
        weekdayLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        weekdayLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        weekdayLabel.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        weekdayLabel.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
    }
    
    func configureWeekday(to week: String) {
        weekdayLabel.text = week
    }
    
    required init?(coder: NSCoder) {
        fatalError("do not use in storyboard")
    }
}

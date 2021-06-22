//
//  DateCVCell.swift
//  MyCalendar
//
//  Created by 이재용 on 2021/06/22.
//

import UIKit

class DateCVCell: UICollectionViewCell {
    static let identifier: String = "DateCVCell"
    // MARK: - Views

    let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "00"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configuareAll()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Do not use in storyboard")
    }
    
    func configureDate(to day: Int) {
        dateLabel.text = "\(day)"
        dateLabel.textColor = UIColor.darkGray
    }
    
    func isPreviousMonthDate() {
        /// 이전 달의 날짜일 때
        /// 색 회색 처리
        /// 안눌리게 해야하나?
        dateLabel.textColor = .lightGray
        
    }
    
    func isFollowingMonthDate() {
        /// 다음 달의 날짜일 때
        /// 색 회색 처리
        /// 이것도 안눌리게?
        dateLabel.textColor = .lightGray
    }
    
    // MARK: - private Methods
    private func configuareAll() {
        setUpViews()
    }
    
    private func setUpViews() {
        addSubview(dateLabel)
        dateLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        dateLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        dateLabel.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        dateLabel.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
    }
}

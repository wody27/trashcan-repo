//
//  WeekdayView.swift
//  MyCalendar
//
//  Created by 이재용 on 2021/06/21.
//

import UIKit

class WeekdayView: UIView {
    
    // MARK: - Property
    var weekdayArray: [String] = ["SUN","MON","TUE","WED","THU","FRI","SAT"]
    
    // MARK: - Views

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setWeekCollectionView()
    }
    
    private func setWeekCollectionView() {
        
        addSubview(weekdayCollectionView)
        weekdayCollectionView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        weekdayCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        weekdayCollectionView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        weekdayCollectionView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
    }

    lazy var weekdayCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.allowsSelection = false
        collectionView.isScrollEnabled = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(WeekdayCVCell.self, forCellWithReuseIdentifier: WeekdayCVCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    
    required init?(coder: NSCoder) {
        fatalError("DO Not Use on Storyboard")
    }
}

extension WeekdayView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeekdayCVCell.identifier, for: indexPath) as? WeekdayCVCell else { return UICollectionViewCell() }
        cell.configureWeekday(to: weekdayArray[indexPath.row])
        return cell
    }
    
}

extension WeekdayView: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 32) / 7
        let height: CGFloat = 11
        return CGSize(width: width, height: height)
    }
}

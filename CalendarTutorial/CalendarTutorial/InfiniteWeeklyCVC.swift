//
//  InfiniteWeeklyCVC.swift
//  CalendarTutorial
//
//  Created by 이재용 on 2021/05/29.
//

import UIKit

class InfiniteWeeklyCVC: UICollectionViewCell {
    static let identifier: String = "InfiniteWeeklyCVC"
    @IBOutlet weak var weeklyCalendarCV: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
//        weeklyCalendarCV.delegate = self
//        weeklyCalendarCV.dataSource = self
    }
}

//extension InfiniteWeeklyCVC: UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//
//    }
//}
//
//extension InfiniteWeeklyCVC: UICollectionViewDelegateFlowLayout {
//
//}

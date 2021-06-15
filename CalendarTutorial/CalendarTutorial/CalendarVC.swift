//
//  CalendarVC.swift
//  CalendarTutorial
//
//  Created by 이재용 on 2021/05/29.
//

import UIKit

class CalendarVC: UIViewController {

    @IBOutlet weak var infiniteWeeklyCV: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        infiniteWeeklyCV.dataSource = self
        infiniteWeeklyCV.delegate = self
    }
    
    
}

extension CalendarVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 500
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InfiniteWeeklyCVC.identifier, for: indexPath) as? InfiniteWeeklyCVC else { return UICollectionViewCell() }
        cell.backgroundColor = indexPath.item == 0 ? UIColor.black : UIColor.systemTeal
        return cell
    }
}
extension CalendarVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: infiniteWeeklyCV.frame.width, height: infiniteWeeklyCV.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
}

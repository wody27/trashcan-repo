//
//  PagingVC.swift
//  CollectionViewFlowLayoutTutorial
//
//  Created by 이재용 on 2021/01/05.
//

import UIKit

class PagingVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let colorBackground: [UIColor] = [.black, .yellow, .blue, .red]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.decelerationRate = .fast
        collectionView.isPagingEnabled = false
        
    }
    
    
}

extension PagingVC: UICollectionViewDelegateFlowLayout {
    
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    //        return CGSize(width: 300, height: self.view.frame.height)
    //    }
    //
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    //        return UIEdgeInsets(top: 20, left: 30, bottom: 100, right: 30)
    //    }
    //
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    //        return 20
    //    }
    
        func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
            guard let layout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
    
            let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing
    
            let estimatedIndex = scrollView.contentOffset.x / cellWidthIncludingSpacing
            let index: Int
            if velocity.x > 0 {
                index = Int(ceil(estimatedIndex))
            } else if velocity.x < 0 {
                index = Int(floor(estimatedIndex))
            } else {
                index = Int(round(estimatedIndex))
            }
    
            targetContentOffset.pointee = CGPoint(x: CGFloat(index) * cellWidthIncludingSpacing, y: 0)
        }
}

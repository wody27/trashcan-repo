//
//  CollectionViewCell.swift
//  CollectionViewFlowLayoutTutorial
//
//  Created by 이재용 on 2021/01/05.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = 3.0
        layer.shadowRadius = 10
        layer.shadowOpacity = 0.4
        layer.shadowOffset = CGSize(width: 5, height: 10)
        self.clipsToBounds = false
    }
}

//
//  Expandable.swift
//  Animator
//
//  Created by 이재용 on 2021/06/17.
//

import UIKit

protocol Expandable {
    func collapse()
    func expand(in collectionView: UICollectionView)
}

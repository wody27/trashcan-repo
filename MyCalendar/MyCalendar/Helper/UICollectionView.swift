//
//  UICollectionView.swift
//  MyCalendar
//
//  Created by 이재용 on 2021/07/07.
//

import UIKit
import Differ

extension UICollectionView {
    func reloadChanges<T: Collection>(from old: T, to new: T) where T.Element: Equatable {
//        animateItemChanges(oldData: old, newData: new, updateData: { self.dataSource = new  as! UICollectionViewDataSource})
    }
}

extension UITableView {
    func reloadChanges<T: Collection>(from old: T, to new: T) where T.Element: Equatable {
        animateRowChanges(oldData: old, newData: new)
    }
}

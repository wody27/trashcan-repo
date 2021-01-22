//
//  DragAndDropVC.swift
//  SmallUnit
//
//  Created by 이재용 on 2021/01/22.
//

import UIKit

class DragAndDropVC: UIViewController {

    private var xOffset: CGFloat = 20
    private var beginningPosition: CGPoint = CGPoint(x: 0, y: 0)
    private var initialMovablePosition: CGPoint = CGPoint(x: 0, y: 0)
    private var trashView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addMovableView(count: 4)
        addTrashView()
     
    }

    private func addTrashView() {
        trashView = UIView(frame: CGRect(x: view.frame.width - Constants.padding - Constants.blockDimension, y: view.frame.height - Constants.padding - Constants.blockDimension, width: Constants.blockDimension, height: Constants.blockDimension))
        trashView!.backgroundColor = .red
        view.addSubview(trashView!)
    }
    
    private func addMovableView(count: Int = 1) {
        for _ in 0..<count {
            let movableView = UIView(frame: CGRect(x: xOffset, y: 64, width: Constants.blockDimension, height: Constants.blockDimension))
            movableView.backgroundColor = .green
            
            view.addSubview(movableView)
            
            let gestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(touched))
            movableView.addGestureRecognizer(gestureRecognizer)
            
            xOffset += Constants.blockDimension + Constants.padding
        }
    }
    
    @objc func touched(_ gestureRecognizer: UIGestureRecognizer) {
        if let touchedView = gestureRecognizer.view {
            if gestureRecognizer.state == .began {
                initialMovablePosition = touchedView.frame.origin
                
            } else if gestureRecognizer.state == .ended {
                touchedView.frame.origin = initialMovablePosition
            }
        }
        if let touchedView = gestureRecognizer.view {
            if gestureRecognizer.state == .began {
                beginningPosition = gestureRecognizer.location(in: touchedView)
            } else if gestureRecognizer.state == .changed {
                let locationView = gestureRecognizer.location(in: touchedView)
                touchedView.frame.origin = CGPoint(x: touchedView.frame.origin.x + locationView.x - beginningPosition.x, y: touchedView.frame.origin.y + locationView.y - beginningPosition.y)
                
                if touchedView.frame.intersects(trashView!.frame) {
                    touchedView.removeFromSuperview()
                    initialMovablePosition = .zero
                }
            }
        }
    }
}

private struct Constants {
    static let padding: CGFloat = 10
    static let blockDimension: CGFloat = 50
}

//
//  ViewController.swift
//  HallowView
//
//  Created by 이재용 on 2021/02/03.
//

import UIKit

class ViewController: UIViewController {
    
    var mainView: UIView = {
        var view = UIView()
        view.backgroundColor = .green
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(mainView)
        mainView.translatesAutoresizingMaskIntoConstraints = false
        
        mainView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive  = true
        mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        mainView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        
        let finder = HollowView(frame: view.frame, transparentRect: CGRect(origin: CGPoint(x: (view.frame.width - 200) / 2, y: (view.frame.height - 200) / 2), size: CGSize(width: 200, height: 200)))
        view.addSubview(finder)
    }
}
// MARK: hollow view class

class HollowView: UIView {
    var transparentRect: CGRect!
    init(frame: CGRect, transparentRect: CGRect) {
        super.init(frame: frame)
        self.isUserInteractionEnabled = false
        self.alpha = 0.5
        self.isOpaque = false
    }
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        backgroundColor?.setFill()
        UIRectFill(rect)
        let holeRectIntersection = transparentRect.intersection( rect )
        UIColor.clear.setFill();
        UIRectFill(holeRectIntersection);
    }
}


override func layoutSubviews() {
    let shapeLayer = CAShapeLayer()
    let circlePath = UIBezierPath(arcCenter: CGPoint(x: 100, y: 100), radius: CGFloat(60), startAngle: CGFloat(0), endAngle: CGFloat(Double.pi * 2), clockwise: true)
    shapeLayer.path = circlePath.cgPath
    // Change the fill color
    shapeLayer.fillColor = UIColor.clear.cgColor
    // You can change the stroke color
    shapeLayer.strokeColor = UIColor.red.cgColor
    // You can change the line width
    shapeLayer.lineWidth = 3.0
    self.layer.addSublayer(shapeLayer)
}





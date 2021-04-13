//
//  ViewController.swift
//  DashedShape
//
//  Created by 이재용 on 2021/01/31.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var halfCircle: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        
        halfCircle.roundCorners(cornerRadius: halfCircle.frame.width / 2, maskedCorners: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
        halfCircle.layer.borderWidth = 1.0
        halfCircle.layer.borderColor = UIColor.black.cgColor
        print("halfCircle: \(halfCircle.frame)")
//        halfCircle.addDashedBorder()
    }
    
    @IBAction func crop(_ sender: Any) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "crop" {
            guard let des = segue.destination as? CropViewController else { return }
            des.cropImg = cropImage1(image: background.image ?? UIImage(), rect: halfCircle.frame)
            
        }
    }
    
    func cropImage1(image: UIImage, rect: CGRect) -> UIImage {
        let cgImage = image.cgImage! // better to write "guard" in realm app
        let croppedCGImage = cgImage.cropping(to: rect)
        return UIImage(cgImage: croppedCGImage!)
    }
}

extension UIView {
    // 특정 모서리만 둥글게
    func roundCorners(cornerRadius: CGFloat, maskedCorners: CACornerMask) {
        clipsToBounds = true
        layer.cornerRadius = cornerRadius
        layer.maskedCorners = CACornerMask(arrayLiteral: maskedCorners)       
    }
    
    func addDashedBorder() {
        let color = UIColor.black.cgColor
        
        let shapeLayer:CAShapeLayer = CAShapeLayer()
        let frameSize = self.frame.size
        let shapeRect = CGRect(x: 0, y: 0, width: frameSize.width, height: frameSize.height)
        
        print("extension: \(shapeRect)")
        shapeLayer.bounds = shapeRect
        shapeLayer.position = CGPoint(x: frameSize.width/2, y: frameSize.height/2)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color
        shapeLayer.lineWidth = 2
        shapeLayer.lineJoin = CAShapeLayerLineJoin.round
        shapeLayer.lineDashPattern = [6,3]
        self.clipsToBounds = true
        shapeLayer.maskedCorners = CACornerMask(arrayLiteral: [.layerMinXMinYCorner, .layerMinXMaxYCorner])
        shapeLayer.path = UIBezierPath(roundedRect: shapeRect, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: self.frame.width / 2, height: self.frame.height / 2)).cgPath
        
        self.layer.addSublayer(shapeLayer)
    }
}





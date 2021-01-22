//
//  CropViewController.swift
//  SmallUnit
//
//  Created by 이재용 on 2021/01/22.
//

import UIKit

class CropViewController: UIViewController {
    
    var initialImage: UIImage?
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var initialImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialImageView.image = initialImage
        scrollView.delegate = self
        
        setupInitialZoomScale()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        centerScrollViewContents()
    }
    
    private func centerScrollViewContents() {
        let frameHeight = initialImageView.frame.size.height
        let frameWidth = initialImageView.frame.size.width
        var point = CGPoint()
        if frameHeight < frameWidth {
            point.x = (frameWidth - scrollView.bounds.width)/2
        } else {
            
            point.y = (frameHeight - scrollView.bounds.height)/2
        }
        scrollView.setContentOffset(point, animated: false)
        scrollView.contentInset = UIEdgeInsets(top: 30, left: 30, bottom: 30, right: 30)
    }
    
    private func setupInitialZoomScale() {
        
        let scrollSize = self.scrollView.bounds.size
        
        if let imagesize = self.initialImageView.image?.size {
            
            let widthRatio = scrollSize.width / imagesize.width
            let heighRatio = scrollSize.height / imagesize.height
            
            let minZoom = max(widthRatio, heighRatio)
            
            scrollView.minimumZoomScale = minZoom
            scrollView.zoomScale = minZoom
        }
    }
}

extension CropViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return initialImageView
    }
}
extension UIView {
    func snapshot(of rect: CGRect? = nil) -> UIImage {
        return UIGraphicsImageRenderer(bounds: rect ?? bounds).image {
            _ in
            drawHierarchy(in: bounds, afterScreenUpdates: true)
        }
    }
}

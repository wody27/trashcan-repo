//
//  SecondViewController.swift
//  DashedShape
//
//  Created by 이재용 on 2021/02/01.
//

import UIKit

class SecondViewController: UIViewController, UIScrollViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    
    var imageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        scrollView.layer.borderWidth = 1
        scrollView.layer.borderColor = UIColor.black.cgColor
        scrollView.delegate = self
        
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.green.cgColor
        
        imageView.frame = CGRect(x: 0, y: 0, width: scrollView.frame.width, height: scrollView.frame.height)
        imageView.image = UIImage(systemName: "imageView")
        imageView.isUserInteractionEnabled = true
        scrollView.addSubview(imageView)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(loadImage))
        tapGestureRecognizer.numberOfTouchesRequired = 1
        imageView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @IBAction func loadImage(_ recognizer: UITapGestureRecognizer) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        present(picker, animated: true, completion: nil)
        
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as! UIImage
        
        imageView.image = image
        imageView.contentMode = .center
        
        scrollView.contentSize = image.size

        print(imageView.frame)
        let scrollViewFrame = scrollView.frame
        let scaleWidth = scrollViewFrame.size.width / scrollView.contentSize.width
        let scaleHeight = scrollViewFrame.size.height / scrollView.contentSize.height
        let minSize = min(scaleWidth, scaleHeight)
        
        scrollView.minimumZoomScale = minSize
        scrollView.maximumZoomScale = 1
        scrollView.zoomScale = minSize
        centerScrollViewContents()
        
        picker.dismiss(animated: true, completion: nil)
        
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        centerScrollViewContents()
    }
 
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func centerScrollViewContents() {
        let boundsSize = scrollView.bounds.size
        var contentsFrame = imageView.frame
        
        if contentsFrame.size.width < boundsSize.width {
            contentsFrame.origin.x = (boundsSize.width - contentsFrame.size.width) / 2
        } else {
            contentsFrame.origin.x = 0
        }
        
        if contentsFrame.size.height < boundsSize.height {
            contentsFrame.origin.y = (boundsSize.height - contentsFrame.size.height) / 2
        } else {
            contentsFrame.origin.y = 0
        }
    }
    
    @IBAction func cropAndSave(_ sender: Any) {
        UIGraphicsBeginImageContextWithOptions(scrollView.bounds.size, true, UIScreen.main.scale)
        let offset = scrollView.contentOffset
        UIGraphicsGetCurrentContext()!.translateBy(x: -offset.x, y: -offset.y)
        scrollView.layer.render(in: UIGraphicsGetCurrentContext()!)
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else { return }
        UIGraphicsEndImageContext()
        
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        
        let alert = UIAlertController(title: "이미지 저장", message: "이미지가 저장되었습니다.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    

}

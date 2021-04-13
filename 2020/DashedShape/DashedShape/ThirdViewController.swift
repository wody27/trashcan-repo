//
//  ThirdViewController.swift
//  DashedShape
//
//  Created by 이재용 on 2021/02/01.
//

import UIKit

class ThirdViewController: UIViewController,UIScrollViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()

        scrollView.delegate = self
        
        scrollView.layer.borderColor = UIColor.black.cgColor
        scrollView.layer.borderWidth = 1.0
        
        
        imageView.layer.borderColor = UIColor.red.cgColor
        imageView.layer.borderWidth = 3.0
        
        let scrollViewFrame = scrollView.frame
        let scaleWidth = scrollViewFrame.size.width / scrollView.contentSize.width
        let scaleHeight = scrollViewFrame.size.height / scrollView.contentSize.height
        let minSize = min(scaleWidth, scaleHeight)
        
        scrollView.minimumZoomScale = minSize
        scrollView.maximumZoomScale = 1
        scrollView.zoomScale = minSize
        
        
        print(scrollView.frame.height)
        print(imageView.frame.size.height)
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }

    @IBAction func getImage(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as! UIImage
        imageView.image = image
        print(scrollView.frame.height)
        print(image.size.height)
        imageView.frame = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func crop(_ sender: Any) {
    }
    
}

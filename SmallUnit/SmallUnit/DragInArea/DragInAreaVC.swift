//
//  DragInAreaVC.swift
//  SmallUnit
//
//  Created by 이재용 on 2021/01/22.
//

import UIKit
import PhotosUI

class DragInAreaVC: UIViewController {

    @IBOutlet weak var imageView: UIImageView!

    @IBAction func imageUpload(_ sender: UIButton) {
        
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        configuration.selectionLimit = 1
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        
        let nav = UINavigationController(rootViewController: picker)
        nav.modalPresentationStyle = .fullScreen
        nav.isNavigationBarHidden = true
        present(nav, animated: true, completion: nil)
    }
    
    
    @IBAction func patchSticker(_ sender: Any) {
        
        
    }
}

extension DragInAreaVC: PHPickerViewControllerDelegate {
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        print("FiRST")
        guard let cropvc = self.storyboard?.instantiateViewController(identifier: "CropVC") as? CropVC else { return }
        print("HELLO")
        
        self.dismiss(animated: true) {
            self.navigationController?.pushViewController(cropvc, animated: true)
        }
        
        if let itemProvider = results.first?.itemProvider, itemProvider.canLoadObject(ofClass: UIImage.self) {
            let previousImage = imageView.image
            itemProvider.loadObject(ofClass: UIImage.self) { [weak self] image, error in
                DispatchQueue.main.sync() {
                    guard let self = self, let image = image as? UIImage, self.imageView.image == previousImage else { return }
                    self.imageView.image = image
                }
            }
        }
    }
    
}

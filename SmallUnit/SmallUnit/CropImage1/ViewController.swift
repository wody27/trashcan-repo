//
//  ViewController.swift
//  SmallUnit
//
//  Created by 이재용 on 2021/01/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    let color: [UIColor] = [UIColor.systemFill, UIColor.systemRed, UIColor.systemTeal, UIColor.systemIndigo]
    
    lazy var picker = UIImagePickerController()
    
    private var chosenImage: UIImage?
    
    let cropSegue = "profileToCropSegue"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        picker.delegate = self
        picker.allowsEditing = false
    }

    @IBAction func addPhoto(_ sender: Any) {
        
        let alert = UIAlertController(title: "원하는 타이틀", message: "원하는 메시지", preferredStyle: .actionSheet)
        let library = UIAlertAction(title: "사진앨범", style: .default) { (action) in
            self.openLibrary()
        }
        let camera = UIAlertAction(title: "카메라", style: .default) { (action) in
            self.openCamera()
            
        }
        
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alert.addAction(library)
        
        alert.addAction(camera)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    private func openLibrary() {
        picker.sourceType = .photoLibrary
        picker.modalPresentationStyle = .fullScreen
        present(picker, animated: true, completion: nil)
    }
    
    private func openCamera() {
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
            picker.modalPresentationStyle = .fullScreen
            present(picker, animated: true, completion: nil)
        } else {
            print("Camera not available")
        }
        
    }
    
    @IBAction func backgroundColorChangedTapped(_ sender: Any) {
        self.view.backgroundColor = color.randomElement()
        
    }
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        self.chosenImage = info[.originalImage] as? UIImage
//        if let image = info[.originalImage] as? UIImage {
//
//            imageView.image = image
//        }
//        self.dismiss(animated: true) {
//            self.performSegue(withIdentifier: self.cropSegue, sender: nil)
//        }
//
        guard let cropVC = self.storyboard?.instantiateViewController(identifier: "CropViewController") as? CropViewController else { return }
        self.dismiss(animated: true) {
            cropVC.initialImage = self.chosenImage
            self.navigationController?.pushViewController(cropVC, animated: true)
        }
        
    }
    
    
    @objc func savedImage(image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeMutableRawPointer?) {
        
        if let error = error {
            print(error)
            return
        }
        print("success")
        
        
    }
}

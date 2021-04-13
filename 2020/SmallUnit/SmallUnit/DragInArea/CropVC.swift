//
//  CropVC.swift
//  SmallUnit
//
//  Created by 이재용 on 2021/01/25.
//

import UIKit

class CropVC: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        scrollView.delegate = self
    }
    
    @IBAction func dismiss(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
}

extension CropVC: UIScrollViewDelegate {
    
}

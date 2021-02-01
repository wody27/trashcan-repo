//
//  CropViewController.swift
//  DashedShape
//
//  Created by 이재용 on 2021/02/01.
//

import UIKit

class CropViewController: UIViewController {

    @IBOutlet weak var cropImage: UIImageView!
    
    var cropImg: UIImage?
    override func viewDidLoad() {
        super.viewDidLoad()

        cropImage.image = cropImg
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  SecondViewController.swift
//  KakaoLinkAPITutorial
//
//  Created by 이재용 on 2021/03/19.
//

import UIKit

class SecondViewController: UIViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if UserDefaults.standard.bool(forKey: "check") {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                guard let vc = self.storyboard?.instantiateViewController(identifier: "ThirdViewController") as? ThirdViewController else { return }
                self.present(vc, animated: true, completion: nil)
                UserDefaults.standard.setValue(false, forKey: "check")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    

}

//
//  StatusBarVC.swift
//  Animator
//
//  Created by 이재용 on 2021/06/18.
//

import UIKit

class StatusBarVC: UIViewController {
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var topConstraint: NSLayoutConstraint!

    var isStatusBarHidden: Bool = false
    override var prefersStatusBarHidden: Bool {
        return isStatusBarHidden
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return isStatusBarHidden ? .slide : .fade
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        print(UIApplication.shared.windows.first!.windowScene?.statusBarManager)

    }
    
    @IBAction func pressButton(_ sender: Any) {
        isStatusBarHidden = !isStatusBarHidden
        if isStatusBarHidden {
            topConstraint.constant = 0
        } else {
            topConstraint.constant = 44
        }
        
        
        UIView.animate(withDuration: 0.5) {
            self.setNeedsStatusBarAppearanceUpdate()
            self.view.layoutIfNeeded()
        }
        
        
    }
    
}

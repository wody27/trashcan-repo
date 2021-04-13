//
//  KeyframesVC.swift
//  AnimationUIView
//
//  Created by 이재용 on 2021/01/19.
//

import UIKit

class KeyframesVC: UIViewController {

    @IBOutlet weak var airplane: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.addKeyframe(withRelativeStartTime: <#T##Double#>, relativeDuration: <#T##Double#>, animations: <#T##() -> Void#>)
        
        UIView.animateKeyframes(withDuration: 4.0, delay: 0.0, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.25, animations: {
                self.airplane.center.x += 200
            })
            UIView.addKeyframe(withRelativeStartTime: 0.25, relativeDuration: 0.25, animations: {
                self.airplane.center.y += 200
            })
            UIView.addKeyframe(withRelativeStartTime: 0.50, relativeDuration: 0.25, animations: {
                self.airplane.center.x -= 200
            })
            UIView.addKeyframe(withRelativeStartTime: 0.75, relativeDuration: 0.25, animations: {
                self.airplane.center.y -= 200
            })
        }, completion: nil)
        
    }

    

}

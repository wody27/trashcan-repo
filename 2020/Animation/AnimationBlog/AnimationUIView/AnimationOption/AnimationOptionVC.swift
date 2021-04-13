//
//  AnimationOptionVC.swift
//  AnimationUIView
//
//  Created by 이재용 on 2021/01/18.
//

import UIKit

class AnimationOptionVC: UIViewController {

    @IBOutlet weak var terminal1: UIImageView!
    @IBOutlet weak var terminal2: UIImageView!
    @IBOutlet weak var terminal3: UIImageView!
    @IBOutlet weak var terminal4: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.terminal1.isHidden = true
//        self.terminal2.isHidden = true
//        self.terminal3.isHidden = true
//        self.terminal4.isHidden = true
    }
        
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.transition(with: terminal1, duration: 1.5, options: [.transitionCurlUp], animations: {
            self.terminal1.isHidden = false
        }, completion: nil)
        
        
        UIView.transition(with: terminal2, duration: 1.5, options: [.transitionFlipFromRight, .repeat], animations: {
//            self.terminal2.isHidden = false
        }, completion: nil)
        
        
        UIView.transition(with: terminal3, duration: 1.5, options:  [.transitionFlipFromTop, .repeat], animations: {
//            self.terminal3.isHidden = false
        }, completion: nil)
        
        
        UIView.transition(with: terminal4, duration: 1.5, options: [.transitionFlipFromBottom, .repeat], animations: {
//            self.terminal4.isHidden = false
        }, completion: nil)
        
    }

}

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
        
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 3.0, delay: 0, options: [.curveLinear, .repeat], animations: {
            
            self.terminal1.frame.origin.x += 4 * self.terminal1.frame.width
        }, completion: nil)
        
        
        UIView.animate(withDuration: 3.0, delay: 0, options: [.curveEaseIn, .repeat], animations: {
            print(self.terminal2.frame.origin.x)
            self.terminal2.frame.origin.x += 4 * self.terminal1.frame.width
            
        }, completion: nil)
        
        UIView.animate(withDuration: 3.0, delay: 0, options: [.curveEaseOut, .repeat], animations: {
            self.terminal3.frame.origin.x += 4 * self.terminal1.frame.width
            
        }, completion: nil)
        
        UIView.animate(withDuration: 3.0, delay: 0, options: [.curveEaseInOut, .repeat], animations: {
            self.terminal4.frame.origin.x += 4 * self.terminal1.frame.width
            
        }, completion: nil)
        
    }

}

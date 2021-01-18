//
//  ViewController.swift
//  AnimationUIView
//
//  Created by 이재용 on 2021/01/18.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var animateView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func buttonTapped(_ sender: Any) {
        
        UIView.animate(withDuration: 1.0, delay: 0, options: [.transitionFlipFromLeft], animations: {
            self.animateView.frame.origin.x -= self.animateView.frame.width
            self.animateView.frame.origin.y -= self.animateView.frame.height
        }) { (_) in
            
            UIView.animate(withDuration: 1.0, delay: 0, options: [.transitionFlipFromLeft], animations: {
                self.animateView.frame.origin.x += 2 * self.animateView.frame.width
                self.animateView.alpha = 0
            }) { (_) in
                UIView.animate(withDuration: 1.0, delay: 0, options: [.transitionFlipFromLeft], animations: {
                    self.animateView.frame.origin.y += 2 * self.animateView.frame.height
                    self.animateView.alpha = 1
                    self.animateView.tintColor = .orange
                }) { _ in
                    UIView.animate(withDuration: 1.0, animations: {
                        self.animateView.frame.origin.x -= self.animateView.frame.width
                        self.animateView.frame.origin.y -= self.animateView.frame.height
                        self.animateView.tintColor = .black
                    }) { (_) in
                        
                    }
                }
            }
        }
    }
    
}


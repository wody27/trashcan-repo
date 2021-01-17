//
//  ViewController.swift
//  Animate
//
//  Created by 이재용 on 2021/01/10.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var animateView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 1.0, animations: {
            self.animateView.center.y += 40
        }, completion: { _ in
            
        })
    }

}


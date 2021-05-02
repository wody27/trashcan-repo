//
//  SecondViewController.swift
//  ButtonAnimationTransition
//
//  Created by 이재용 on 2021/05/01.
//

import TransitionButton
import UIKit

class SecondViewController: UIViewController, UIViewControllerTransitioningDelegate {

    override var modalPresentationStyle: UIModalPresentationStyle {
        get {
            return .fullScreen
        }
        set {}
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.transitioningDelegate = self
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return FadeAnimation(transitionDuration: 0.5, startingAlpha: 0.8)
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return FadeAnimation(transitionDuration: 0.5, startingAlpha: 0.8)
    }
}

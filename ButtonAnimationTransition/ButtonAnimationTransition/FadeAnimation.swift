//
//  FadeAnimation.swift
//  ButtonAnimationTransition
//
//  Created by 이재용 on 2021/05/02.
//

import UIKit

class FadeAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    
    
    var transitionDuration: TimeInterval = 0.5
    var startingAlpha: CGFloat = 0.0
    
    convenience init(transitionDuration: TimeInterval, startingAlpha: CGFloat) {
        self.init()
        self.transitionDuration = transitionDuration
        self.startingAlpha = startingAlpha
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return transitionDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        
        let toView = transitionContext.view(forKey: .to)!
        let fromView = transitionContext.view(forKey: .from)!
        
        toView.alpha = startingAlpha
        fromView.alpha = 0.8
        
        toView.frame = containerView.frame
        containerView.addSubview(toView)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            toView.alpha = 1.0
            fromView.alpha = 0.0
        }) { _ in
            fromView.alpha = 1.0
            transitionContext.completeTransition(true)
        }
    }
}
    

//
//  ViewController.swift
//  ButtonAnimationTransition
//
//  Created by 이재용 on 2021/05/01.
//
import TransitionButton
import UIKit

class ViewController: UIViewController {
    
    let button = TransitionButton(frame: CGRect(x: 100, y: 100, width: 100, height: 40))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(button)
        button.backgroundColor = .red
        button.setTitle("butoon", for: .normal)
        button.cornerRadius = 20
        button.spinnerColor = .white
        button.addTarget(self, action: #selector(animateTouchDown(_:)), for: .touchDown)
        button.addTarget(self, action: #selector(animateTouchUp(_:)), for: .touchUpInside)
        button.addTarget(self, action: #selector(animateTouchUp(_:)), for: .touchUpOutside)
        
    }
    
    @objc func buttonAction(_ button: TransitionButton) {
        animateView(button)
        button.startAnimation()
        let qualityOfServiceClass = DispatchQoS.QoSClass.background
        let backgroundQueue = DispatchQueue.global(qos: qualityOfServiceClass)
        backgroundQueue.async {
            sleep(3)
            
            DispatchQueue.main.async {
                button.stopAnimation(animationStyle: .expand, completion: {
                    let secondVC = self.storyboard?.instantiateViewController(identifier: "SecondViewController") as! SecondViewController
                    self.present(secondVC, animated: true, completion: nil)
                })
            }
        }
    }
    
    @objc func animateTouchDown(_ viewToAnimate: UIView) {
        UIView.animate(withDuration: 0.15, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.5, options: .curveEaseIn) {
            viewToAnimate.transform = CGAffineTransform(scaleX: 0.92, y: 0.92)
        }
    }
    
    @objc func animateTouchUp(_ viewToAnimate: UIView) {
        UIView.animate(withDuration: 0.15, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 2, options: .curveEaseIn) {
            viewToAnimate.transform = CGAffineTransform(scaleX: 1, y: 1)
            DispatchQueue.main.async {
                
                let secondVC = self.storyboard?.instantiateViewController(identifier: "SecondViewController") as! SecondViewController
                secondVC.modalPresentationStyle = .custom
                self.present(secondVC, animated: true, completion: nil)
            }
        }
    }
    
    
    fileprivate func animateView(_ viewToAnimate: UIView) {
        UIView.animate(withDuration: 0.15, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.5, options: .curveEaseIn) {
            viewToAnimate.transform = CGAffineTransform(scaleX: 0.92, y: 0.92)
        } completion: { _ in
            UIView.animate(withDuration: 0.15, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 2, options: .curveEaseIn, animations: {
                viewToAnimate.transform = CGAffineTransform(scaleX: 1, y: 1)
            }, completion: nil)
        }

    }
}

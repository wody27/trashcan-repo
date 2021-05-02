//
//  ViewController.swift
//  AnimationPractice
//
//  Created by 이재용 on 2021/05/02.
//

import UIKit

class ViewController: UIViewController {
    
    let animateView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        view.layer.cornerRadius = view.frame.width/2
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let button: UIButton = {
        let button = UIButton()
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = 20
        button.setTitle("애니메이션 실행", for: .normal)
        button.backgroundColor = .red
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateView.layer.cornerRadius = animateView.frame.height/2
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(button)
        button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100).isActive = true
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.widthAnchor.constraint(equalToConstant: 150).isActive = true
        button.heightAnchor.constraint(equalToConstant: 60).isActive = true
        button.addTarget(self, action: #selector(pressB), for: .touchUpInside)
        
        view.addSubview(animateView)
        animateView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        animateView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        animateView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        animateView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        animateView.clipsToBounds = false
        animateView.layer.masksToBounds = true
    }
    
    @objc func pressB() {
        self.animation(with: self.animateView, completion: nil)
    }
    
    func animation(with viewToAnimate: UIView, completion: (()->Void)?) {
        let expandAnimation = CABasicAnimation(keyPath: "transform.scale")
        let expandScale = (UIScreen.main.bounds.size.height/viewToAnimate.frame.size.height)*2
        expandAnimation.fromValue = 1.0
        expandAnimation.toValue = expandScale
        expandAnimation.timingFunction = CAMediaTimingFunction(controlPoints: 0.95, 0.02, 1, 0.05)
        expandAnimation.duration = 0.4
        expandAnimation.fillMode = .forwards
        expandAnimation.isRemovedOnCompletion = false

        
        CATransaction.setCompletionBlock {
            completion?()
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                viewToAnimate.layer.removeAllAnimations()
            }
        }

        viewToAnimate.layer.add(expandAnimation,forKey: expandAnimation.keyPath)
        CATransaction.commit()
    }
    
}

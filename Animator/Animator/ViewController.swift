//
//  ViewController.swift
//  Animator
//
//  Created by 이재용 on 2021/06/17.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    
    private var hiddenCells: [ExpandableCell] = []
    private var expandedCell: ExpandableCell?
    private var isStatusBarHidden = false
    
    override var prefersStatusBarHidden: Bool {
        return isStatusBarHidden
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .slide
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureAll()
    }


    private func configureAll() {
        configureCollectionView()
//        configureSlider()
//        configureRedbox()
//        configureAnimator()
    }
    
    private func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func configureSlider() {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(slider)

        slider.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: -30).isActive = true
        slider.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        slider.addTarget(self, action: #selector(sliderChanged), for: .valueChanged)
    }
    private func configureRedbox() {
        let redBox = UIView(frame: CGRect(x: -64, y: 0, width: 128, height: 128))
        redBox.translatesAutoresizingMaskIntoConstraints = false
        redBox.backgroundColor = UIColor.red
        redBox.center.y = view.center.y
        view.addSubview(redBox)
//        animator = UIViewPropertyAnimator(duration: 2, curve: .easeInOut) { [unowned self, redBox] in
//            redBox.center.x = self.view.frame.width
//            redBox.transform = CGAffineTransform(rotationAngle: CGFloat.pi).scaledBy(x: 0.001, y: 0.001)
//        }
    }
    
    @objc func sliderChanged(_ sender: UISlider) {
//        animator.fractionComplete = CGFloat(sender.value)
    }
    
    private func configureAnimator() {
        
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: "ExpandableCell", for: indexPath)
    }
    
    
}

extension ViewController: UICollectionViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // scrollView
        if collectionView.contentOffset.y < 0 || collectionView.contentOffset.y > collectionView.contentSize.height - collectionView.frame.height {
            return
        }
        
        let dampingRatio: CGFloat = 0.8
        let initialVelocity = CGVector.zero
        let springParameters = UISpringTimingParameters(dampingRatio: dampingRatio, initialVelocity: initialVelocity)
        let animator = UIViewPropertyAnimator(duration: 0.8, timingParameters: springParameters)

        self.view.isUserInteractionEnabled = false
        
        if let selectedCell = expandedCell {
            // not expanded
            isStatusBarHidden = false
            topConstraint.constant = 44
            
            animator.addAnimations {
                selectedCell.collapse()
                
                for cell in self.hiddenCells {
                    cell.show()
                }
            }
            
            animator.addCompletion { _ in
                collectionView.isScrollEnabled = true
                self.expandedCell = nil
                self.hiddenCells.removeAll()
            }
        } else {
            // expanded
            isStatusBarHidden = true
            topConstraint.constant = 0
            
            collectionView.isScrollEnabled = false
            
            let selectedCell = collectionView.cellForItem(at: indexPath) as! ExpandableCell
            let frameOfSelectedCell = selectedCell.frame
            
            expandedCell = selectedCell
            hiddenCells = collectionView.visibleCells.map {
                $0 as! ExpandableCell
            }.filter {
                $0 != selectedCell
            }
            
            animator.addAnimations {
                selectedCell.expand(in: collectionView)
                
                for cell in self.hiddenCells {
                    cell.hide(in: collectionView, frameOfSelectedCell: frameOfSelectedCell)
                }
            }
        }
        
        animator.addAnimations {
            self.setNeedsStatusBarAppearanceUpdate()
            self.view.layoutIfNeeded()
        }
        
        animator.addCompletion { _ in
            self.view.isUserInteractionEnabled = true
        }
        
        animator.startAnimation()
    }
}

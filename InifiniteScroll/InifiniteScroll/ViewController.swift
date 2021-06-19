//
//  ViewController.swift
//  InifiniteScroll
//
//  Created by 이재용 on 2021/06/15.
//

import UIKit

class ViewController: UIViewController {

    private var bannerView: BannerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        setUpBannerView()
    }
    
    private func setUpUI() {
        
        self.view.backgroundColor = #colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1)
        
        bannerView = BannerView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        self.view.addSubview(bannerView)
        bannerView.backgroundColor = UIColor(red: CGFloat.random(in: 0..<255), green: CGFloat.random(in: 0..<255), blue: CGFloat.random(in: 0..<255), alpha: 1.0)
    }

    private func setUpBannerView() {
        
        bannerView.reloadData(configuration: nil, numberOfItems: 5) { (bannerView, index) -> UIView in
            return self.itemView(at: index)
        }
    }

    private func itemView(at index: Int) -> UIImageView {
        
        return UIImageView()
    }
}


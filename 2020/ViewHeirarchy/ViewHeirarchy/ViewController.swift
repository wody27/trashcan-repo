//
//  ViewController.swift
//  ViewHeirarchy
//
//  Created by 이재용 on 2021/02/06.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var indigoView: UIView!
    @IBOutlet weak var tealView: UIView!
    @IBOutlet weak var yellowView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.bringSubviewToFront(yellowView)
    }


}


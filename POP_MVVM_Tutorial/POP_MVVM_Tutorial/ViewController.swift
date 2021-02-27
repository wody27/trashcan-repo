//
//  ViewController.swift
//  POP_MVVM_Tutorial
//
//  Created by 이재용 on 2021/02/27.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
//        let nib = UINib(nibName: ExampleTVC.identifier, bundle: nil)
//        tableView.register(nib, forCellReuseIdentifier: ExampleTVC.identifier)
        
        for font in UIFont.familyNames {
            print(font)
        }
    
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ExampleTVC.identifier, for: indexPath) as! ExampleTVC
        
        cell.configure(title: "스위치", titleFont: UIFont(name: "Futura", size: 18.0) ?? UIFont(), titleColor: .blue, switchOn: false)
        
        cell.conf
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 83.0
    }
}


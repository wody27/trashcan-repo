//
//  ExampleTVC.swift
//  POP_MVVM_Tutorial
//
//  Created by 이재용 on 2021/02/27.
//

import UIKit

class ExampleTVC: UITableViewCell {
    static let identifier: String = "ExampleTVC"
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var customSwitch: UISwitch!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configure(
           title: String,
           titleFont: UIFont,
           titleColor: UIColor,
        switchColor: UIColor = .purple,
        isSwitchOn: Bool = false)
       {
        label.text = title
        label.font = titleFont
        label.textColor = titleColor
    
        customSwitch.isOn = isSwitchOn
        customSwitch.tintColor = switchColor
    }
    
    func configure(withDelegate delegate: SwitchWithTextCellProtocol)
        {
        
        }
}

protocol SwitchWithTextCellProtocol {
    var title: String { get }
    var titleFont: UIFont { get }
    var titleColor: UIColor { get }
    
    var switchOn: Bool { get }
    var switchColor: UIColor { get }

    func onSwitchToggleOn(on: Bool)
}

extension SwitchWithTextCellProtocol {
    var switchColor: UIColor {
        return .purple
    }
}

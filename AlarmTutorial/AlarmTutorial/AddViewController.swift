//
//  AddViewController.swift
//  AlarmTutorial
//
//  Created by 이재용 on 2021/06/23.
//

import UIKit

class AddViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var titleField: UITextField!
    @IBOutlet var bodyField: UITextField!
    @IBOutlet var datePicker: UIDatePicker!
    
    public var completion: ((String, String, Date) -> Void)?
    
    
    @objc func didTapSaveButton() {
        if let titleText = titleField.text, !titleText.isEmpty,
            let bodyText = bodyField.text, !bodyText.isEmpty {

            let targetDate = datePicker.date

            completion?(titleText, bodyText, targetDate)

        }
    }

}

//
//  ViewController.swift
//  Mail
//
//  Created by 이재용 on 2021/01/14.
//

import UIKit
import MessageUI

class ViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func sendMail(_ sender: Any) {
        
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            self.present(mailComposeViewController, animated: true, completion: nil)
            print("can send mail")
        } else {
            self.showSendMailErrorAlert()
        }
    }
    
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        mailComposerVC.setSubject("BeMe iOS 문의 메일")
        mailComposerVC.setToRecipients(["BeMe@naver.com"])
        mailComposerVC.setMessageBody("몽글팀이 빠르게 처리할 수 있게 메일 제목에 간단하게 어떤 문의인지 적어주세요!\n\n1. 문의 유형(문의/신고/버그제보/기타) : \n 2. 회원 아이디 (필요시 기입) : \n 3. 문의 내용 :", isHTML: false)
        return mailComposerVC
    }
    
    func showSendMailErrorAlert() {
        
        let sendMailErrorAlert = UIAlertController(title: "메일을 전송 실패", message: "아이폰 이메일 설정을 확인하고 다시 시도해주세요.", preferredStyle: .alert)
        
        let cancelButton = UIAlertAction(title: "확인", style: .cancel, handler: nil)
        
        sendMailErrorAlert.addAction(cancelButton)
        self.present(sendMailErrorAlert, animated: true, completion: nil)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
}


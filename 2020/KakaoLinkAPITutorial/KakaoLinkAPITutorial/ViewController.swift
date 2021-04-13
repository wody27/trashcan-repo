//
//  ViewController.swift
//  KakaoLinkAPITutorial
//
//  Created by 이재용 on 2021/03/18.
//

import UIKit
import KakaoSDKLink
import KakaoSDKTemplate
import KakaoSDKCommon

class ViewController: UIViewController {
    
    
    @IBOutlet weak var label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = Var.PageURL
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleNotification), name: .init("fromKakaoTalk"), object: nil)
    }

    @objc func handleNotification(_ notification: NSNotification) {
        if notification.name.rawValue == "fromKakaoTalk" {
            if let object = notification.object as? [String: String] {
                label.text = object["gift_id"]
            }
        }
    }
    @IBAction func shareKakao(_ sender: Any) {
       
        let feedTemplateJsonStringData =
            """
            {
                "object_type": "feed",
                "content": {
                    "title": "딸기 치즈 케익",
                    "description": "#케익 #딸기 #삼평동 #카페 #분위기 #소개팅",
                    "image_url": "http://mud-kage.kakao.co.kr/dn/Q2iNx/btqgeRgV54P/VLdBs9cvyn8BJXB3o7N8UK/kakaolink40_original.png",
                    "link": {
                            "android_execution_params": "gift_id=2",
                            "ios_execution_params": "gift_id=2"
                    }
                },
                "buttons": [
                    {
                        "title": "앱으로 보기",
                        "link": {
                            "android_execution_params": "gift_id=2",
                            "ios_execution_params": "gift_id=2"
                        }
                    }
                ]
            }
            """.data(using: .utf8)!
        
        if let templatable = try? SdkJSONDecoder.custom.decode(FeedTemplate.self, from: feedTemplateJsonStringData) {
            
            LinkApi.shared.defaultLink(templatable: templatable) {(linkResult, error) in
                if let error = error {
                    print(error)
                } else {
                    print("defaultLink() success.")
                    if let linkResult = linkResult {
                        UIApplication.shared.open(linkResult.url, options: [:], completionHandler: nil)
                        print(linkResult.url)
                    }
                }
            }
        } else {
            print("Templatable error")
        }
        
        print("End")
    }
    
    
}


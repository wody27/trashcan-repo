//
//  ViewController.swift
//  AlarmTutorial
//
//  Created by 이재용 on 2021/06/23.
//

import UserNotifications
import UIKit

class ViewController: UIViewController{
    
    @IBOutlet var table: UITableView!

    var models = [MyReminder]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
    }
    
    @IBAction func didTapAdd() {
        guard let vc = storyboard?.instantiateViewController(identifier: "AddViewController") as? AddViewController else { return }
        vc.title = "New Reminder"
        vc.navigationItem.largeTitleDisplayMode = .never
        vc.completion = { title, body, date in
            
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func didTapTest() {
        // test 알람 주기
        UNUserNotificationCenter.current()
            .requestAuthorization(options: [.alert,.badge,.sound]) { success, error in
                if success {
                    // schedule test
                    self.scheduleTest()
                } else if error != nil {
                    print("error occurred")
                }
            }
    }
    
    func scheduleTest() {
        // reqeust UserNO
        let content = UNMutableNotificationContent()
        content.title = "Hello world"
        content.sound = .default
        content.body =  "긴 바디입니다.긴 바디입니다.긴 바디입니다.긴 바디입니다.긴 바디입니다.긴 바디입니다.긴 바디입니다.긴 바디입니다.긴 바디입니다."
        let targetDate = Date().addingTimeInterval(10)
        let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: targetDate), repeats: true)
        
        let request = UNNotificationRequest(identifier: "id_for_user", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { error in
            if error != nil {
                print("알람 설정에서 무언가이상합니다.")
            }
        }
    }
}


extension ViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

}


extension ViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = models[indexPath.row].title
        let date = models[indexPath.row].date

        let formatter = DateFormatter()
        formatter.dateFormat = "MMM, dd, YYYY"
        cell.detailTextLabel?.text = formatter.string(from: date)

        cell.textLabel?.font = UIFont(name: "Arial", size: 25)
        cell.detailTextLabel?.font = UIFont(name: "Arial", size: 22)
        return cell
    }

}


struct MyReminder {
    let title: String
    let date: Date
    let identifier: String
}

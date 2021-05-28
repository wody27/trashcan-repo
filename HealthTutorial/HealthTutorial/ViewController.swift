//
//  ViewController.swift
//  HealthTutorial
//
//  Created by 이재용 on 2021/05/27.
//

import UIKit
import HealthKit

struct UserHealthProfile {
    var age: Int?
    var biologicalSex: HKBiologicalSex?
    var bloodType: HKBloodType?
    var heightInMeters: Double?
    var weightInKilograms: Double?
    
    var bodyMassIndex: Double? {
      
      guard let weightInKilograms = weightInKilograms,
        let heightInMeters = heightInMeters,
        heightInMeters > 0 else {
          return nil
      }
      
      return (weightInKilograms/(heightInMeters*heightInMeters))
    }
}

class ViewController: UIViewController {
    
    
    //MARK: - Variables
    var userHealthProfile = UserHealthProfile()
    
    //MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
    
        tableView.delegate = self
        tableView.dataSource = self
        loadSleepAnalysis()
        loadAndDisplayAgeSexAndBloodtype()
    }

    private func loadSleepAnalysis() {
        guard let sleepAnalysis = HKSampleType.categoryType(forIdentifier: .sleepAnalysis) else {
            print("????")
            return
        }
        
        HealthKitSetupManager.getMostRecentlySample(for: sleepAnalysis) { sample, error in
            
            guard let sample = sample else {
                if let error = error {
                    print("error")
                
                }
                
                self.displayAlert(for: error!)
                return
            }
            
            print(sample)
            
        }
    }
    private func loadAndDisplayAgeSexAndBloodtype() {
        do {
            let userAgeSexAndBloodtype = try HealthKitSetupManager.getAgeSexAndBloodType()
            userHealthProfile.age = userAgeSexAndBloodtype.age
            userHealthProfile.biologicalSex = userAgeSexAndBloodtype.biologicalSex
            userHealthProfile.bloodType = userAgeSexAndBloodtype.bloodType
        } catch let error {
            self.displayAlert(for: error)
        }
    }
    
    func displayAlert(for error: Error) {
        let alertVC = UIAlertController()
        alertVC.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
        alertVC.message = "\(error.localizedDescription)"
        print("HGEl")
        present(alertVC, animated: true, completion: nil)
    }
    
    @IBOutlet weak var authorizeButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func authorizeHealthKit(_ sender: Any) {
        HealthKitSetupManager.authorizeHealthKit { authorized, error in
            if let error = error {
                print(error)
            }
            
            print("Healthkit Successfully Authorized.")
            self.loadSleepAnalysis()
        }
    }
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "test"
        return cell
    }
    
}

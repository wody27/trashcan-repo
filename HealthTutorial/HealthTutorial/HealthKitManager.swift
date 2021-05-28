//
//  HealthKitManager.swift
//  HealthTutorial
//
//  Created by 이재용 on 2021/05/28.
//

import Foundation
import HealthKit


private enum HealthkitSetupError: Error {
    case notAvailableOnDevice
    case dataTypeNotAvailable
}

class HealthKitSetupManager {
  
    class func getMostRecentlySample(for sampleType: HKSampleType, completion: @escaping ([HKSample]?, Error?) -> Void)  {
        
  
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate,
                                              ascending: false)
        let limit = 30
        
        let sampleQuery = HKSampleQuery(sampleType: sampleType,
                                        predicate: nil,
                                        limit: limit,
                                        sortDescriptors: [sortDescriptor]) { (query, samples, error) in
            
            
            if let result = samples {
                for item in result {
                    if let sample = item as? HKCategorySample {
                        let value = (sample.value == HKCategoryValueSleepAnalysis.inBed.rawValue) ? "InBed" : "Asleep"
                        print("Healthkit sleep: \(sample.startDate) \(sample.endDate) - value: \(value)")
    
                    
                    }
                }
            }
    
        }
    
        HKHealthStore().execute(sampleQuery)

    }
    class func getAgeSexAndBloodType() throws -> (age:Int,
                                                  biologicalSex: HKBiologicalSex,
                                                  bloodType: HKBloodType) {
        let healthKitStore = HKHealthStore()
        
        do {
            let birthday        = try healthKitStore.dateOfBirthComponents()
            let biologicalSex   = try healthKitStore.biologicalSex()
            let bloodType       = try healthKitStore.bloodType()
            let today               = Date()
            let calendar            = Calendar.current
            let todayDateComponents = calendar.dateComponents([.year], from: today)
            let thisYear            = todayDateComponents.year!
            let age                 = thisYear - birthday.year!
            
            let unwrappedBiologicalSex  = biologicalSex.biologicalSex
            let unwrappedBloodType      = bloodType.bloodType

            return (age, unwrappedBiologicalSex, unwrappedBloodType)
        }
    }
    
    class func authorizeHealthKit(completion: @escaping (Bool, Error?) -> Swift.Void) {
        guard HKHealthStore.isHealthDataAvailable() else {
            completion(false, HealthkitSetupError.notAvailableOnDevice)
            return
        }
        guard let dateOfBirth = HKObjectType.characteristicType(forIdentifier: .dateOfBirth),
              let bloodType = HKObjectType.characteristicType(forIdentifier: .bloodType),
              let biologicalSex = HKObjectType.characteristicType(forIdentifier: .biologicalSex),
              let bodyMassIndex = HKObjectType.quantityType(forIdentifier: .bodyMassIndex),
              let height = HKObjectType.quantityType(forIdentifier: .height),
              let bodyMass = HKObjectType.quantityType(forIdentifier: .bodyMass),
              let activeEnergy = HKObjectType.quantityType(forIdentifier: .activeEnergyBurned),
              let sleepAnalysis = HKObjectType.categoryType(forIdentifier: .sleepAnalysis),
              let sleepChanges = HKObjectType.categoryType(forIdentifier: .sleepChanges)else {
            completion(false, HealthkitSetupError.dataTypeNotAvailable)
            return
        }
        
        let healthKitTypesToWrite: Set<HKSampleType> = [bodyMassIndex,
                                                        activeEnergy,
                                                        HKObjectType.workoutType()]
        let healthKitTypesToRead: Set<HKObjectType> = [dateOfBirth,
                                                       bloodType,
                                                       biologicalSex,
                                                       bodyMassIndex,
                                                       height,
                                                       bodyMass,
                                                       sleepAnalysis,
                                                       sleepChanges,
                                                       HKObjectType.workoutType()]
        
        HKHealthStore().requestAuthorization(toShare: healthKitTypesToWrite, read: healthKitTypesToRead) { success, error in
            completion(success, error)
        }

        
    }
}

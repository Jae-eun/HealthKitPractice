//
//  ViewController.swift
//  healthKitPractice
//
//  Created by 이재은 on 22/01/2019.
//  Copyright © 2019 이재은. All rights reserved.
//

import UIKit
import HealthKit

class ViewController: UIViewController {

  let healthStore = HKHealthStore()
  
  let stepType = HKQuantityType.quantityType(forIdentifier: .stepCount)!
  let woType = HKObjectType.workoutType()
  
  override func viewDidLoad() {
    super.viewDidLoad()

    healthStore.requestAuthorization(toShare: [],
                               read: [stepType, woType],
                               completion: { (isSuccess, error) in
      if isSuccess {
        print("Success")
        self.getSteps()
      } else {
        print("Failed")
      }
    })
  }

  func getSteps() {
    let startDate = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: Date())!
    
    let endDate = Date()
    
    print("Collecting workouts between \(startDate) and \(endDate)")
    
    let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: HKQueryOptions.strictEndDate)
    
    let query = HKSampleQuery(sampleType: HKQuantityType.quantityType(forIdentifier: .distanceWalkingRunning)!, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { (query, results, error) in
      if let results = results {
        for item in results {
          print(item)
        }
      }
    }
    healthStore.execute(query)
  }
}


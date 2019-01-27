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
  
  fileprivate var healthKitManager = HealthKitManager()
  
  @IBOutlet weak var stepLabel: UILabel!
  @IBOutlet weak var distanceLabel: UILabel!
  
  
  let endDate = Date()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    guard let startDate = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: Date()) else { return }
    
    healthKitManager.retrieveHealthKitValue(startDate: startDate, endDate: endDate, quantityFor: HKUnit.meter(), quantityTypeIdentifier: .distanceWalkingRunning) { distance in
        DispatchQueue.main.async {
          self.distanceLabel.text = "\(distance) km"
        }
    }
    
    healthKitManager.retrieveHealthKitValue(startDate: startDate, endDate: endDate, quantityFor: HKUnit.count(), quantityTypeIdentifier: .stepCount) { stepCount in
      DispatchQueue.main.async {
        self.stepLabel.text = "\(stepCount) 걸음"
      }
    }
  }
  //  let healthStore = HKHealthStore()
  //
  //  let stepType = HKQuantityType.quantityType(forIdentifier: .stepCount)!
  //  let distanceType = HKQuantityType.quantityType(forIdentifier: .distanceWalkingRunning)!
  //
  //  override func viewDidLoad() {
  //    super.viewDidLoad()
  //
  //    healthStore.requestAuthorization(toShare: [],
  //                                     read: [stepType, distanceType],
  //                                     completion: { (isSuccess, error) in
  //                                      if isSuccess {
  //                                        print("Success")
  //                                        self.getSteps()
  //                                      } else {
  //                                        print("Failed")
  //                                      }
  //    })
  //  }
  //
  //  func getSteps() {
  //    guard let startDate = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: Date()) else { return }
  //
  //    let endDate = Date()
  //
  //    print("Collecting workouts between \(startDate) and \(endDate)")
  //
  //    let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: HKQueryOptions.strictEndDate)
  //
  //    let query = HKStatisticsQuery(quantityType: stepType, quantitySamplePredicate: predicate, options: .cumulativeSum) { (_, result, error) in
  //      var resultCount = 0
  //      guard let result = result else {
  //        print("Failed to fetch steps rate")
  //        return
  //      }
  //      if let sum = result.sumQuantity() {
  //        resultCount = Int(sum.doubleValue(for: HKUnit.count()))
  //      }
  //      DispatchQueue.main.async {
  //        self.stepLabel.text = "\(resultCount) 걸음"
  //      }
  //    }
  //    let query2 = HKStatisticsQuery(quantityType: distanceType, quantitySamplePredicate: predicate, options: .cumulativeSum) { (_, result2, error) in
  //      var resultCount2 = 0.0
  //      guard let result2 = result2 else {
  //        print("Failed to fetch distances")
  //        return
  //      }
  //      if let sum2 = result2.sumQuantity() {
  //        resultCount2 = sum2.doubleValue(for: HKUnit.meter())
  //      }
  //      var distance = ""
  //
  //      if resultCount2 < 1000 {
  //        distance = "\(resultCount2) + m"
  //      } else {
  //        let distanceInKilometer = resultCount2 / 1000
  //        distance = String(format:"%.1f", distanceInKilometer) + " km"
  //      }
  //      DispatchQueue.main.async {
  //        self.distanceLabel.text = "\(distance)"
  //      }
  //    }
  //    healthStore.execute(query)
  //    healthStore.execute(query2)
  //  }
}

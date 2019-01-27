//
//  HealthKitManagerType.swift
//  healthKitPractice
//
//  Created by 이재은 on 26/01/2019.
//  Copyright © 2019 이재은. All rights reserved.
//

import Foundation
import HealthKit

protocol HealthKitManagerType {
  func findHealthKitValue(startDate: Date, endDate: Date, quantityFor: HKUnit, quantityTypeIdentifier: HKQuantityTypeIdentifier, completion: @escaping (_ quantityValue: Double) -> Void)
}

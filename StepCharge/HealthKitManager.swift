//
//  HealthKitManager.swift
//  StepCharge
//
//  Created by Amit Aharoni on 12/6/23.
//

import HealthKit
import Combine

class HealthKitManager: ObservableObject {
    let healthStore = HKHealthStore()
    @Published var steps = 0 // Published property to notify SwiftUI of changes

    init() {
        if HKHealthStore.isHealthDataAvailable() {
            requestAuthorization()
        } else {
            // Health data is not available on this device
        }
    }

    func requestAuthorization() {
        guard let stepCountType = HKObjectType.quantityType(forIdentifier: .stepCount) else {
            return // This should never fail
        }

        healthStore.requestAuthorization(toShare: nil, read: Set([stepCountType])) { [weak self] success, error in
            if success {
                self?.queryStepCount()
            } else {
                // Handle errors or lack of permissions here
            }
        }
    }

    func queryStepCount() {
        guard let stepCountType = HKObjectType.quantityType(forIdentifier: .stepCount) else {
            return // This should never fail
        }

        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for: now)
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictStartDate)

        let query = HKStatisticsQuery(quantityType: stepCountType, quantitySamplePredicate: predicate, options: .cumulativeSum) { [weak self] _, result, error in
            guard let result = result, let sum = result.sumQuantity() else {
                // Handle any errors or no data scenarios here
                return
            }

            let stepsCount = sum.doubleValue(for: HKUnit.count())
            DispatchQueue.main.async {
                self?.steps = Int(stepsCount) // Update the published steps property
            }
        }

        healthStore.execute(query)
    }
}

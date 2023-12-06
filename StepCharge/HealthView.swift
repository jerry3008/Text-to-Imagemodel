//
//  HealthKitManager.swift
//  StepCharge
//
//  Created by Amit Aharoni on 12/6/23.
//

import HealthKit
import Combine

import SwiftUI

struct HealthView: View {
    @StateObject var healthKitManager = HealthKitManager()

    var body: some View {
        VStack {
            Text("Step Count")
                .font(.headline)

            Text("\(healthKitManager.steps)")
                .font(.largeTitle)
                .padding()
        }
        .onAppear {
            healthKitManager.queryStepCount()
        }
    }
}

struct HealthView_Previews: PreviewProvider {
    static var previews: some View {
        HealthView()
    }
}


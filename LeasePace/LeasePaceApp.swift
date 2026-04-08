//
//  LeasePaceApp.swift
//  LeasePace
//
//  Created by Gustavo Vazquez on 3/22/26.
//

import SwiftUI

@main
struct LeasePaceApp: App {
    var body: some Scene {
        WindowGroup {
            GarageView(
                vehicle: Vehicle(
                    year: 2026,
                    make: "Mercedes",
                    model: "C300"
                )
            )
        }
    }
}

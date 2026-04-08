//
//  DashboardView.swift
//  LeasePace
//
//  Created by Great-Visions-Code on 3/30/26
//

import SwiftUI

struct DashboardView: View {
    let vehicle: Vehicle
    let lease: Lease
    
    private var dashboardVM: DashboardViewModel {
        DashboardViewModel(vehicle: vehicle, lease: lease)
    }
    
    var body: some View {
        VStack {
            //  App Title
            VStack {
                Text("LeasePace")
            }
            .padding()
            
            //  Vehicle Display Name
            VStack {
                Text("\(vehicle.displayName) displayName")
                    .bold()
            }
            .padding()
            
            //  Hero text
            VStack {
                Text("✅ You're On Pace")
            }
            .padding()
            
            //  Mileage under/over allowance
            VStack {
                Text("\(dashboardVM.totalMilesAllowed) totalMilesAllowed")
                    .bold()
                Text("")
                Text("2045.48")
                Text("Under Allowance")
            }
            .padding()
            
            // Cost due end of lease
            VStack {
                Text("Forecast Due End of Lease")
                Text("$0")
                Text("under by 8,782.19 miles")
            }
            .padding()
            
            // Daily Mileage Pace
            VStack {
                Text("Daily Mileage Pace")
                Text("Allowed: 33 mi/day")
                Text("Current: 28 mi/day")
                Text("Below Pace")
            }
            .padding()
            
            // Lease progression bar
            VStack {
                Text("\(dashboardVM.leaseEndDate) leaseEndDate")
                    .bold()
                Text("")
                Text("\(dashboardVM.totalLeaseDays) totalLeaseDays")
                    .bold()
                Text("")

                Text("Lease Progress")
                Text("18%")
            }
            .padding()
            
        }
        .padding()
    }
}

#Preview {
    
    DashboardView(
        vehicle: Vehicle(
            year: 2026,
            make: "Mercedes",
            model: "C300"
        ),
        
        lease: Lease(
            startDate: Calendar.current.date(
                from: DateComponents(
                    year: 2026,
                    month: 1,
                    day: 1)
            )!,
            termMonths: 36,
            milesAllowedPerYear: 12000,
            costPerMile: 0.25,
            currentMileage: 1000)
    )
}

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
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                
                // Header
                VStack(alignment: .leading, spacing: 8) {
                    Text(vehicle.displayName)
                        .font(.title2)
                        .bold()
                    
                    Text(dashboardVM.paceStatusText)
                        .font(.headline)
                }
                
                // Current Position
                VStack(alignment: .leading, spacing: 8) {
                    Text("Current Position")
                        .font(.headline)
                    
                    Text("Total Miles Allowed: \(dashboardVM.totalMilesAllowed)")
                        .bold()
                    Text("Projected Miles at End: \(dashboardVM.projectedMilesAtEndOfLease.formattedTwoDecimal)")
                        .bold()
                    Text("Allowed Miles To Date: \(dashboardVM.expectedMileageByToday.formattedTwoDecimal)")
                        .bold()
                    Text("Current Mileage: \(lease.currentMileage)")
                        .bold()
                    Text("Difference To Date: \(abs(dashboardVM.differenceInMilesAllowedToDate).formattedWholeNumber) miles")
                        .bold()
                    Text(dashboardVM.differenceInMilesAllowedToDate >= 0 ? "Under Allowance To Date" : "Over Allowance To Date")
                        .bold()
                }
                
                // End of Lease Forecast
                VStack(alignment: .leading, spacing: 8) {
                    Text("End of Lease Forecast")
                        .font(.headline)
                    
                    Text("Projected Overage Cost: \(dashboardVM.projectedOverageCost.formattedCurrency)")
                        .bold()
                    Text(dashboardVM.projectedMileageSummaryText)
                        .bold()
                }
                
                // Daily Pace
                VStack(alignment: .leading, spacing: 8) {
                    Text("Daily Mileage Pace")
                        .font(.headline)
                    
                    Text("Allowed: \(dashboardVM.allowedMilesPerDay.formattedTwoDecimal) mi/day")
                        .bold()
                    Text("Current: \(dashboardVM.currentMilesPerDay.formattedTwoDecimal) mi/day")
                        .bold()
                }
                
                // Lease Timeline
                VStack(alignment: .leading, spacing: 8) {
                    Text("Lease Timeline")
                        .font(.headline)
                    
                    Text("End Date: \(dashboardVM.leaseEndDate.formattedDateShortString)")
                        .bold()
                    Text("Total Lease Days: \(dashboardVM.totalLeaseDays)")
                        .bold()
                    Text("Days Elapsed: \(dashboardVM.daysElapsed)")
                        .bold()
                    Text("Days Remaining: \(dashboardVM.daysRemaining)")
                        .bold()
                }
                
                // Lease Progress
                VStack(alignment: .leading, spacing: 8) {
                    Text("Lease Progress")
                        .font(.headline)
                    
                    Text("\(dashboardVM.leaseProgressPercentage)%")
                        .bold()
                }
            }
            .padding()
        }
        .navigationTitle("Dashboard")
        .navigationBarTitleDisplayMode(.inline)
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
                    month: 2,
                    day: 24
    )
            )!,
            termMonths: 48,
            milesAllowedPerYear: 12000,
            costPerMile: 0.25,
            currentMileage: 2436)
    )
}

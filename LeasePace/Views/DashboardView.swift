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
        DashboardViewModel(
            vehicle: vehicle,
            lease: lease)
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Header
                VStack(spacing: 8) {
                    Text(vehicle.displayName)
                        .font(.headline)
                    
                    Text(dashboardVM.paceStatusText)
                        .font(.title2)
                        .bold()
                }
                
                // End of Lease Forecast
                DashboardCardView(title: "End of Lease Forecast") {
                    VStack(spacing: 8) {
                        Text("Total Allowed: \(dashboardVM.totalMilesAllowed)")
                        
                        Divider()
                        
                        Text("Projected Miles at End: \(dashboardVM.projectedMilesAtEndOfLease.formattedTwoDecimal)")
                        
                        Divider()

                        Text("Projected Overage Cost: \(dashboardVM.projectedOverageCost.formattedCurrency)")
                            .bold()
                        
                        Divider()

                        Text(dashboardVM.projectedMileageSummaryText)
                            .bold()
                    }
                    .frame(maxWidth: .infinity)
                }
                
                // Daily Average Pace
                DashboardCardView(title: "Daily Mileage Pace") {
                    VStack(spacing: 8) {
                        Text("Allowed: \(dashboardVM.allowedMilesPerDay.formattedTwoDecimal)")
                        
                        Divider()
                        
                        Text("Current: \(dashboardVM.currentMilesPerDay.formattedTwoDecimal)")
                    }
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity)
                }
                
                // Monthly Average Pace
                DashboardCardView(title: "Monthly Mileage Pace") {
                    VStack(spacing: 8) {
                        Text("Allowed: \(dashboardVM.allowedMilesPerMonth.formattedTwoDecimal)")
                        
                        Divider()
                        
                        Text("Current: \(dashboardVM.currentMilesPerMonth.formattedTwoDecimal)")
                    }
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity)
                }
                
                // Mileage to Date
                DashboardCardView(title: "Mileage to Date") {
                    VStack(spacing: 8) {
                        Text("\(abs(dashboardVM.differenceInMilesAllowedToDate).formattedWholeNumber) miles \(dashboardVM.differenceInMilesAllowedToDate >= 0 ? "Under Pace to date" : "Over Pace to date"  )")
                        
                        Divider()
                        
                        Text("Allowed to Date: \(dashboardVM.expectedMileageByToday.formattedWholeNumber)")

                        Divider()
                        
                        Text("Current: \(lease.currentMileage.formattedWithCommas)")
                    }
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity)
                }
                
                // Lease Progress Timeline
                DashboardCardView(title: "Lease Progress") {
                    VStack(spacing: 8) {
                        Text("Progress: \(dashboardVM.leaseProgressPercentage)%")
                        
                        Divider()
                        
                        Text("Days since Start: \(dashboardVM.daysElapsed)")
                        
                        Divider()
                        
                        Text("Remaining Days: \(dashboardVM.daysRemaining)")
                        
                        Divider()
                        
                        Text("Start: \(lease.startDate.formattedDateShortString)")
                        
                        Divider()
                        
                        Text("End: \(dashboardVM.leaseEndDate.formattedDateShortString)")
                    }
                    .foregroundStyle(.secondary)
                }
            }
            .padding()
        }
        .navigationTitle("Dashboard")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
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
                currentMileage: 2914
            )
        )
    }
}

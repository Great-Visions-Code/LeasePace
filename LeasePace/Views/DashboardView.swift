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
            lease: lease
        )
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
                
                // Mileage to Date
                DashboardCardView(title: "Mileage to Date") {
                    VStack(spacing: 8) {
                        Text("\(abs(dashboardVM.differenceInMilesAllowedToDate).formattedWholeNumber) miles")
                            .bold()
                            .foregroundStyle(.primary)
                        Text("\(dashboardVM.differenceInMilesAllowedToDate >= 0 ? "Under pace to date" : "Over pace to date")")
                            
                        Divider()
                            
                        Text("Allowed: \(dashboardVM.expectedMileageByToday.formattedWholeNumber) mi")

                        Divider()
                            
                        Text("Current: \(lease.currentMileage.formattedWithCommas) mi")
                    }
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity)
                }
                
                // End of Lease Forecast
                DashboardCardView(title: "End of Lease Forecast") {
                    VStack(spacing: 8) {
                        Text("Total Allowed: \(dashboardVM.totalMilesAllowed.formattedWithCommas) mi")
                        
                        Divider()
                        
                        Text("Projected End Miles: \(dashboardVM.projectedMilesAtEndOfLease.formattedWholeNumber) mi")
                        
                        Divider()

                        Text("Projected Overage Cost: \(dashboardVM.projectedOverageCost.formattedCurrency)")
                            .bold()
                        
                        Divider()

                        Text(dashboardVM.projectedMileageSummaryText)
                            .bold()
                    }
                    .frame(maxWidth: .infinity)
                }
                
                // Daily Mileage Pace
                DashboardCardView(title: "Daily Mileage Pace") {
                    VStack(spacing: 8) {
                        Text("Allowed: \(dashboardVM.allowedMilesPerDay.formattedTwoDecimal) mi/day")
                        
                        Divider()
                        
                        Text("Current: \(dashboardVM.currentMilesPerDay.formattedTwoDecimal) mi/day")
                    }
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity)
                }
                
                // Monthly Mileage Pace
                DashboardCardView(title: "Monthly Mileage Pace") {
                    VStack(spacing: 8) {
                        Text("Allowed: \(dashboardVM.allowedMilesPerMonth.formattedTwoDecimal) mi/month")
                        
                        Divider()
                        
                        Text("Current: \(dashboardVM.currentMilesPerMonth.formattedTwoDecimal) mi/month")
                    }
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity)
                }
                
                // Lease Progress Timeline
                DashboardCardView(title: "Lease Progress") {
                    VStack(spacing: 8) {
                        Text("\(dashboardVM.leaseProgressPercentage)% Complete")
                            .bold()
                            .foregroundStyle(.primary)
                        ProgressView(value: dashboardVM.leaseProgress)
                        
                        Divider()
                        
                        Text("\(dashboardVM.daysElapsed) days elapsed")
                        
                        Divider()
                        
                        Text("\(dashboardVM.daysRemaining) days remaining")
                        
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

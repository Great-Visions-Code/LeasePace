//
//  DashboardView.swift
//  LeasePace
//
//  Created by Great-Visions-Code on 3/30/26
//

import SwiftUI

struct DashboardView: View {
    
    @State private var showDeleteConfirmation = false
    
    let vehicle: Vehicle
    let lease: Lease
    let garageVM: GarageViewModel?
    let onDelete: (() -> Void)?
    
    private var activeLease: Lease {
        garageVM?.savedLease ?? lease
    }
    
    private var activeVehicle: Vehicle {
        garageVM?.savedVehicle ?? vehicle
    }
    
    private var dashboardVM: DashboardViewModel {
        DashboardViewModel(
            vehicle: activeVehicle,
            lease: activeLease
        )
    }
    
    init(
        vehicle: Vehicle,
        lease: Lease,
        garageVM: GarageViewModel? = nil,
        onDelete: (() -> Void)? = nil
    ) {
        self.vehicle = vehicle
        self.lease = lease
        self.garageVM = garageVM
        self.onDelete = onDelete
    }
    
    var body: some View {
        
        ScrollView {
            VStack(spacing: 20) {
                
                // MARK: - Header
                
                VStack(spacing: 8) {
                    Text(activeVehicle.displayName)
                        .font(.headline)
                    
                    Text(dashboardVM.paceStatusText)
                        .font(.title2)
                        .bold()
                        .foregroundStyle(dashboardVM.paceStatusColor)
                }
                
                // MARK: - Mileage to Date
                
                DashboardCardView(title: "Mileage to Date") {
                    VStack(spacing: 10) {
                        
                        Text("\(abs(dashboardVM.differenceInMilesAllowedToDate).formattedWholeNumber) mi")
                            .font(.title2)
                            .bold()
                            .foregroundStyle(.primary)
                        
                        Text(
                            dashboardVM.differenceInMilesAllowedToDate >= 0
                             ? "Under pace to date"
                             : "Over pace to date"
                        )
                            .foregroundStyle(
                                dashboardVM.differenceInMilesAllowedToDate >= 0
                                ? .green
                                : .red
                            )
                        
                        Divider()
                        
                        VStack(spacing: 6) {
                            Text("Allowed: \(dashboardVM.expectedMileageByToday.formattedWholeNumber) mi")
                            Text("Current: \(activeLease.currentMileage.formattedWithCommas) mi")
                        }
                        .foregroundStyle(.secondary)
                    }
                    .frame(maxWidth: .infinity)
                }

                // MARK: - End of Lease Forecast
                DashboardCardView(title: "End of Lease Forecast") {
                    
                    VStack(spacing: 10) {
                        Text(dashboardVM.projectedOverageCost > 0
                             ? dashboardVM.projectedOverageCost.formattedCurrency
                             : "On Track"
                        )
                            .font(.title2)
                            .bold()
                            .foregroundStyle(
                                dashboardVM.projectedOverageCost > 0
                                ? .red
                                : .green
                            )
                        
                        Text(
                            dashboardVM.projectedOverageCost > 0
                            ? "Projected overage cost"
                            : "Projected to stay within lease allowance"
                        )
                        .foregroundStyle(.secondary)
                        
                        Divider()
                        
                        VStack(spacing: 6) {
                            Text("Projected End Mileage: \(dashboardVM.projectedMilesAtEndOfLease.formattedWholeNumber) mi")
                            Text("Lease Allowance: \(dashboardVM.totalMilesAllowed.formattedWithCommas) mi")
                            Text("Overage Rate: \(activeLease.costPerMile.formattedCurrency)/mi")
                        }
                        .foregroundStyle(.secondary)
                        
                        Divider()
                        
                        Text(dashboardVM.projectedMileageSummaryText)
                            .font(.subheadline)
                            .foregroundStyle(.primary)
                            .multilineTextAlignment(.center)
                    }
                    .frame(maxWidth: .infinity)
                }
                
                // MARK: - Daily Mileage Pace
                
                DashboardCardView(title: "Daily Mileage Pace") {
                    
                    VStack(spacing: 10) {
                        
                        Text("\(dashboardVM.currentMilesPerDay.formattedTwoDecimal) mi/day")
                            .font(.title3)
                            .bold()
                            .foregroundStyle(
                                dashboardVM.currentMilesPerDay > dashboardVM.allowedMilesPerDay
                                ? .red
                                : .green
                            )
                        
                        Text("Current pace")
                            .foregroundStyle(.secondary)
                        
                        Divider()
                        
                        Text("Allowed Daily Pace: \(dashboardVM.allowedMilesPerDay.formattedTwoDecimal) mi/day")
                            .foregroundStyle(.secondary)
                    }
                    .frame(maxWidth: .infinity)
                }
                
                // MARK: - Monthly Mileage Pace
                
                DashboardCardView(title: "Monthly Mileage Pace") {
                    VStack(spacing: 10) {
                        
                        Text("\(dashboardVM.currentMilesPerMonth.formattedTwoDecimal) mi/month")
                            .font(.title3)
                            .bold()
                            .foregroundStyle(
                                dashboardVM.currentMilesPerMonth > dashboardVM.allowedMilesPerMonth
                                ? .red
                                : .green
                            )
                        
                        Text("Current pace")
                            .foregroundStyle(.secondary)
                        
                        Divider()
                        
                        Text("Allowed Monthly Pace: \(dashboardVM.allowedMilesPerMonth.formattedTwoDecimal) mi/month")
                            .foregroundStyle(.secondary)
                    }
                    .frame(maxWidth: .infinity)
                }
                
                // MARK: - Lease Progress
                
                DashboardCardView(title: "Lease Progress") {
                    VStack(spacing: 10) {
                        
                        Text("\(dashboardVM.leaseProgressPercentage)%")
                            .font(.title2)
                            .bold()
                            .foregroundStyle(.primary)
                        
                        Text("Lease progress")
                            .foregroundStyle(.secondary)
                        
                        ProgressView(value: dashboardVM.leaseProgress)
                        
                        Divider()
                        
                        VStack(spacing: 6) {
                            
                            Text("\(dashboardVM.daysElapsed) days elapsed")
                            
                            Text("\(dashboardVM.daysRemaining) days remaining")
                        }
                        .foregroundStyle(.secondary)
                        
                        Divider()
                        
                        VStack(spacing: 6) {
                            
                            Text("Start Date: \(activeLease.startDate.formattedDateShortString)")
                            
                            Text("End Date: \(dashboardVM.leaseEndDate.formattedDateShortString)")
                        }
                        .foregroundStyle(.secondary)
                    }
                    .frame(maxWidth: .infinity)
                }
                
                if let garageVM {
                    NavigationLink {
                        UpdateMileageView(
                            vehicle: activeVehicle,
                            lease: activeLease,
                            garageVM: garageVM
                        )
                    } label: {
                        PrimaryButtonView(title: "Update Current Mileage")
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Dashboard")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Delete Vehicle", role: .destructive) {
                    showDeleteConfirmation = true
                }
            }
        }
        .alert("Delete Vehicle?", isPresented: $showDeleteConfirmation) {
            Button("Cancel", role: .cancel) {}
            
            Button("Delete", role: .destructive) {
                garageVM?.deleteSavedData()
                onDelete?()
            }
        } message: {
            Text("This will remove the vehicle and lease details from LeasePace. You can add them again anytime.")
        }
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
            ),
            garageVM: GarageViewModel()
        )
    }
}

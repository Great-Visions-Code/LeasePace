//
//  UpdateMileageView.swift
//  LeasePace
//
//  Created by Great-Visions-Code on 4/26/26.
//

import SwiftUI

struct UpdateMileageView: View {
    
    let vehicle: Vehicle
    let lease: Lease
    
    @State private var updatedMileage = ""
    @State private var navigationToDashboard = false
    
    init(
        vehicle: Vehicle,
        lease: Lease
    ) {
        self.vehicle = vehicle
        self.lease = lease
        _updatedMileage = State(initialValue: "\(lease.currentMileage)")
    }
     
    // MARK: - Updated Lease

    private var updatedLease: Lease {
        Lease(
            startDate: lease.startDate,
            termMonths: lease.termMonths,
            milesAllowedPerYear: lease.milesAllowedPerYear,
            costPerMile: lease.costPerMile,
            currentMileage: Int(updatedMileage) ?? lease.currentMileage
        )
    }
    
    // MARK: - Validation
    
    private var isFormValid: Bool {
        guard
            let mileage = Int(updatedMileage),
            mileage >= lease.currentMileage,
            mileage <= 999999
        else {
            return false
        }
        return true
    }
    
    // MARK: - Body
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                
                // MARK: - Vehicle Display
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(vehicle.displayName)
                        .font(.headline)
                    
                    Text("Current Mileage: \(lease.currentMileage.formattedWithCommas) mi")
                        .foregroundStyle(.secondary)
                }
                
                // MARK: Mileage Input
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Updated Mileage")
                        .bold()
                    
                    TextField("Enter updated mileage", text: $updatedMileage)
                        .keyboardType(.numberPad)
                        .textFieldStyle(.roundedBorder)
                }
                
                // MARK: - Save Button
                
                Button {
                    LeaseStorage.save(
                        vehicle: vehicle,
                        lease: updatedLease
                    )
                    
                    navigationToDashboard = true
                } label: {
                    Text("Save Mileage")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .foregroundStyle(.white)
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .fill(isFormValid
                                      ? .blue
                                      : .gray
                                )
                        )
                }
                .disabled(!isFormValid)
                .padding(.top, 12)
            }
            .padding()
        }
        .navigationTitle("Update Mileage")
        .navigationBarTitleDisplayMode(.inline)
        .navigationDestination(isPresented: $navigationToDashboard) {
            DashboardView(
                vehicle: vehicle,
                lease: updatedLease
            )
        }
    }
}

#Preview{
    NavigationStack {
        UpdateMileageView(
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
                    currentMileage: 3250
                )
            )
    }
}


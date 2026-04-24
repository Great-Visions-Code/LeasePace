//
//  LeaseDetailsInputView.swift
//  LeasePace
//
//  Created by Great-Visions-Code on 4/10/26
//

import SwiftUI

struct LeaseDetailsInputView: View {
    // MARK: - Properties
        
    let vehicle: Vehicle
        
    @State private var startDate = Date()
    @State private var termMonths = 36
    @State private var milesAllowedPerYear = ""
    @State private var costPerMile = ""
    @State private var currentMileage = ""
    
    // MARK: - Validation
        
    private var isFormValid: Bool {
            
        guard
            let milesAllowedPerYearInt = Int(milesAllowedPerYear),
            milesAllowedPerYearInt > 999,
            milesAllowedPerYearInt <= 30000,
            
            let costPerMile = Double(costPerMile),
            costPerMile >= 0,
            costPerMile <= 1.00,
            
            let currentMileage = Int(currentMileage),
            currentMileage >= 0,
            currentMileage <= 999999
            
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
                        .foregroundStyle(.secondary)
                }
                
                // MARK: - Lease Start Date
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Lease Start Date")
                        .bold()
                    
                    DatePicker(
                        "Start Date",
                        selection: $startDate,
                        displayedComponents: .date
                    )
                    .labelsHidden()
                }
                
                // MARK: - Lease Term
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Lease Term")
                        .bold()
                    
                    Picker("Lease Term", selection: $termMonths) {
                        Text("24 Months").tag(24)
                        Text("36 Months").tag(36)
                        Text("39 Months").tag(39)
                        Text("48 Months").tag(48)
                    }
                    .pickerStyle(.menu)
                }
                
                // MARK: - Miles Allowed Per Year
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Miles Allowed Per Year")
                        .bold()
                    
                    TextField("12000", text: $milesAllowedPerYear)
                        .keyboardType(.numberPad)
                        .textFieldStyle(.roundedBorder)
                }
                
                // MARK: - Cost Per Mile
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Cost Per Mile")
                        .bold()
                    
                    TextField("0.25", text: $costPerMile)
                        .keyboardType(.decimalPad)
                        .textFieldStyle(.roundedBorder)
                }
                    
                // MARK: - Current Mileage
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Current Mileage")
                        .bold()
                    
                    TextField("10000", text: $currentMileage)
                        .keyboardType(.numberPad)
                        .textFieldStyle(.roundedBorder)
                }
                
                // MARK: - Continue Navigation
                
                NavigationLink {
                    DashboardView(
                        vehicle: vehicle,
                        lease: Lease(
                            startDate: startDate,
                            termMonths: termMonths,
                            milesAllowedPerYear: Int(milesAllowedPerYear) ?? 0,
                            costPerMile: Double(costPerMile) ?? 0,
                            currentMileage: Int(currentMileage) ?? 0
                        )
                    )
                } label: {
                    Text("Continue")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .fill(isFormValid ? .blue : .gray)
                        )
                }
                .disabled(!isFormValid)
                .padding(.top, 12)
            }
            .padding()
        }
        .navigationTitle("Lease Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        LeaseDetailsInputView(
            vehicle: Vehicle(
                year: 2026,
                make: "Mercedes",
                model: "C300"
            )
        )
    }
}

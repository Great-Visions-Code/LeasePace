//
//  LeaseDetailsInputView.swift
//  LeasePace
//
//  Created by Great-Visions-Code on 4/10/26
//

import SwiftUI

struct LeaseDetailsInputView: View {
    
    let vehicle: Vehicle
    
    @State private var startDate = Date()
    @State private var termMonths = 36
    @State private var milesAllowedPerYear = ""
    @State private var costPerMile = ""
    @State private var currentMileage = ""
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                
                VStack(alignment: .leading, spacing: 4) {
                    
                    Text(vehicle.displayName)
                        .foregroundStyle(.secondary)
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Lease Start Date")
                        .bold()
                    
                    DatePicker("Start Date", selection: $startDate, displayedComponents: .date)
                        .labelsHidden()
                }
                
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
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Miles Allowed Per Year")
                        .bold()
                    
                    TextField("0000..", text: $milesAllowedPerYear)
                        .keyboardType(.numberPad)
                        .textFieldStyle(.roundedBorder)
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Cost Per Mile")
                        .bold()
                    
                    TextField("0.00", text: $costPerMile)
                        .keyboardType(.decimalPad)
                        .textFieldStyle(.roundedBorder)
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Current Mileage")
                        .bold()
                    
                    TextField("1234.5", text: $currentMileage)
                        .keyboardType(.numberPad)
                        .textFieldStyle(.roundedBorder)
                }
                
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
                        .frame(maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .fill(.blue)
                        )
                }
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

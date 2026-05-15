//
//  GarageView.swift
//  LeasePace
//
//  Created by Great-Visions-Code on 4/1/26
//

import SwiftUI

struct GarageView: View {
        
    // MARK: - ViewModel
    
    @StateObject private var garageVM = GarageViewModel()
    
    // MARK: - Body
    
    var body: some View {
        NavigationStack {
            Group {
                if let vehicle = garageVM.savedVehicle,
                   let lease = garageVM.savedLease {
                        
                    // MARK: - Saved Lease Dashboard
                        
                    DashboardView(
                        vehicle: vehicle,
                        lease: lease,
                        garageVM: garageVM,
                        onDelete: garageVM.deleteSavedData
                    )
                } else {
                        
                    // MARK: - Empty State
                        
                    VStack(spacing: 20) {
                    
                        Text("Add your vehicle to start tracking your lease mileage.")
                            .foregroundStyle(.secondary)
                            .multilineTextAlignment(.center)
                            
                        NavigationLink {
                            VehicleDetailsInputView(garageVM: garageVM)
                            
                        } label: {
                            PrimaryButtonView(title: "Add Vehicle")
                        }
                        
                        Spacer()
                    }
                    .padding()
                }
            }
            .navigationTitle("Garage")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                garageVM.loadSavedData()
            }
        }
    }
}

#Preview {
    GarageView()
}

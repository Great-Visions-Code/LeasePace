//
//  GarageView.swift
//  LeasePace
//
//  Created by Great-Visions-Code on 4/1/26
//

import SwiftUI

struct GarageView: View {
        
    // MARK: - Saved Data
    
    @State private var savedLease: Lease?
    @State private var savedVehicle: Vehicle?
    
    // MARK: - Body
    
    var body: some View {
        NavigationStack {
            Group {
                if let vehicle = savedVehicle,
                   let lease = savedLease {
                        
                    // MARK: - Saved Lease Dashboard
                        
                    DashboardView(
                        vehicle: vehicle,
                        lease: lease,
                        onDelete: {
                            savedVehicle = nil
                            savedLease = nil
                        }
                    )
                } else {
                        
                    // MARK: - Empty State
                        
                    VStack(spacing: 20) {
                    
                        Text("Add your vehicle to start tracking your lease mileage.")
                            .foregroundStyle(.secondary)
                            .multilineTextAlignment(.center)
                            
                        NavigationLink {
                            VehicleDetailsInputView()
                            
                        } label: {
                            Text("Add Vehicle")
                                .font(.headline)
                                .foregroundStyle(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 16)
                                        .fill(.blue)
                                )
                        }
                        Spacer()
                    }
                    .padding()
                }
            }
            .navigationTitle("Garage")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                print("Garage appeared")
                
                savedVehicle = LeaseStorage.loadVehicle()
                savedLease = LeaseStorage.loadLease()
                
                print("Loaded vehicle:", savedVehicle?.displayName ?? "nil")
                print("Loaded lease:", savedLease as Any)
            }
        }
    }
}

#Preview {
    GarageView()
}

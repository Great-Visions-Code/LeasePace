//
//  GarageView.swift
//  LeasePace
//
// Created by Great-Visions-Code on 4/1/26
//

import SwiftUI

struct GarageView: View {
    let vehicle: Vehicle
    
    var body: some View {
        NavigationStack {
            
            // Vehicle Display Name
            VStack {
                HStack {
                    Text(vehicle.displayName)
                    
                    Spacer()
                    
                    NavigationLink {
                        DashboardView(
                            vehicle: Vehicle(
                                year: 2026,
                                make: "Mercedes",
                                model: "C300"
                            ),
                            
                            lease: Lease(
                                startDate: Calendar.current.date(
                                    from: DateComponents(year: 2026, month: 1, day: 1)
                                )!,
                                termMonths: 36,
                                milesAllowedPerYear: 12000,
                                costPerMile: 0.25,
                                currentMileage: 1000)
                        )
                        
                    } label: {
                        Text("Continue")
                            .font(.headline)
                            .foregroundColor(.white)
                    }
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color(.blue.opacity(0.8)))
                    )
                
                Spacer()
                
            }
            .navigationTitle(Text("Garage"))
            .padding()
        }
    }
}

#Preview {
    GarageView(
        vehicle: Vehicle(
            year: 2026,
            make: "Mercedes",
            model: "C300"
        )
    )
}

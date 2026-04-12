//
//  GarageView.swift
//  LeasePace
//
// Created by Great-Visions-Code on 4/1/26
//

import SwiftUI

struct GarageView: View {
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                
                // MARK: - Empty State Message
                Text("Add your vehicle to start tracking your lease mileage.")
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                
                // MARK: - Add Vehicle Navigation
                NavigationLink {
                    VehicleDetailsInputView()
                } label: {
                    Text("Add Vehicle")
                        .font(.headline)
                        .foregroundColor(.white)
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
            .navigationTitle("Garage")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    GarageView()
}

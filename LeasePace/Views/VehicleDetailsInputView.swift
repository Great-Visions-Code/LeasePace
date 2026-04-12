//
//  VehicleDetailsInputView.swift
//  LeasePace
//
//  Created by Great-Visions-Code on 4/11/26.
//

import SwiftUI

struct VehicleDetailsInputView: View {
        
    @State private var year = ""
    @State private var make = ""
    @State private var model = ""
    @State private var nickname = ""
        
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                    
                // MARK: - Intro Text
                VStack(alignment: .leading, spacing: 4) {
                    Text("Enter the vehicle tied to this lease.")
                        .foregroundStyle(.secondary)
                }
                
                // MARK: - Year Input
                VStack(alignment: .leading, spacing: 8) {
                    Text("Year")
                        .bold()
                        
                    TextField("2026", text: $year)
                        .keyboardType(.numberPad)
                        .textFieldStyle(.roundedBorder)
                }
                    
                // MARK: - Make Input
                VStack(alignment: .leading, spacing: 8) {
                    Text("Make")
                        .bold()
                    
                    TextField("Land Rover", text: $make)
                        .textFieldStyle(.roundedBorder)
                }
                    
                // MARK: - Model Input
                VStack(alignment: .leading, spacing: 8) {
                    Text("Model")
                        .bold()
                        
                    TextField("Range Rover", text: $model)
                        .textFieldStyle(.roundedBorder)
                }
                    
                // MARK: - Optional Nickname Input
                VStack(alignment: .leading, spacing: 8) {
                    Text("Nickname (Optional)")
                        .bold()
                        
                    TextField("Daily Driver", text: $nickname)
                        .textFieldStyle(.roundedBorder)
                }
                    
                // MARK: - Continue Navigation
                NavigationLink {
                    LeaseDetailsInputView(
                        vehicle: Vehicle(
                            year: Int(year) ?? 0,
                            make: make,
                            model: model,
                            nickname: nickname.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? nil : nickname
                        )
                    )
                } label: {
                    Text("Continue")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .fill(.blue)
                        )
                }
                .padding(.top, 12)
            }
            .padding()
        }
        .navigationTitle("Vehicle Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        VehicleDetailsInputView()
    }
}

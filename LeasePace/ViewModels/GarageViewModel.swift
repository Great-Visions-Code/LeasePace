//
//  GarageViewModel.swift
//  LeasePace
//
//  Created by Great-Visions-Code on 5/5/26.
//

import Foundation
import Combine

final class GarageViewModel: ObservableObject {
    
    // MARK: - Published State
    
    @Published var savedVehicle: Vehicle?
    @Published var savedLease: Lease?
    
    // MARK: - Computed Properties
    
    var hasSavedLease: Bool {
        savedVehicle != nil && savedLease != nil
    }
    
    // MARK: - Data Actions
    
    func loadSavedData() {
        savedVehicle = LeaseStorage.loadVehicle()
        savedLease = LeaseStorage.loadLease()
    }
    
    func save(
        vehicle: Vehicle,
        lease: Lease
    ) {
        LeaseStorage.save(
            vehicle: vehicle,
            lease: lease
        )
        
        savedVehicle = vehicle
        savedLease = lease
    }
    
    func deleteSavedData() {
        LeaseStorage.clear()
        
        savedVehicle = nil
        savedLease = nil
    }
}


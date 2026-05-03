//
//  LeaseStorage.swift
//  LeasePace
//
//  Created by Great-Visions-Code on 5/1/26.
//

import Foundation

final class LeaseStorage {
    
    private static let leaseKey = "savedLease"
    private static let vehicleKey = "savedVehicle"
    
    // MARK: - Save
    
    static func save(
        vehicle: Vehicle,
        lease: Lease
        ) {
        let encoder = JSONEncoder()
            
        if let vehicleData = try? encoder.encode(vehicle) {
            UserDefaults.standard.set(vehicleData, forKey: vehicleKey)
        }
            
        if let leaseData = try? encoder.encode(lease) {
                UserDefaults.standard.set(leaseData, forKey: leaseKey)
            }
    }
    
    // MARK: - Load
    
    static func loadVehicle() -> Vehicle? {
        guard
            let data = UserDefaults.standard.data(forKey: vehicleKey),
            let vehicle = try? JSONDecoder().decode(Vehicle.self, from: data)
        else {
            return nil
        }
        return vehicle
    }
    
    static func loadLease() -> Lease? {
        guard
            let data = UserDefaults.standard.data(forKey: leaseKey),
            let lease = try? JSONDecoder().decode(Lease.self, from: data)
        else {
            return nil
        }
        return lease
    }
    
    // MARK: - Clear
    
    static func clear() {
        UserDefaults.standard.removeObject(forKey: vehicleKey)
        UserDefaults.standard.removeObject(forKey: leaseKey)
    }
}

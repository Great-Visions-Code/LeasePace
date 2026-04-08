//
//  DashboardViewModel.swift
//  LeasePace
//
// Created by Great-Visions-Code on 4/7/26
//

import Foundation
import Combine

final class DashboardViewModel: ObservableObject {
    let vehicle: Vehicle
    let lease: Lease
    
    init(vehicle: Vehicle, lease: Lease) {
        self.vehicle = vehicle
        self.lease = lease
    }
    
    //  Calculate total miles from lease.milesAllowedPerYear x lease.termMonths / 12 months in a year
    var totalMilesAllowed: Int {
        (lease.milesAllowedPerYear * lease.termMonths)/12
    }
    
    // Calculate leaseEndDate from lease.startDate and lease.termMonths
    var leaseEndDate: Date {
        Calendar.current.date(
            byAdding: .month,
            value: lease.termMonths,
            to: lease.startDate
        )!
    }
    
    var totalLeaseDays: Int {
        let days = Calendar.current.dateComponents(
            [.day],
            from: lease.startDate,
            to: leaseEndDate
        ) .day ?? 0
        
        return max(days, 1)
    }
    
}

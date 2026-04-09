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
    
    ///  Calculate total miles from lease.milesAllowedPerYear x lease.termMonths / 12 months in a year
    var totalMilesAllowed: Int {
        (lease.milesAllowedPerYear * lease.termMonths)/12
    }
    
    /// Calculate leaseEndDate from lease.startDate and lease.termMonths
    var leaseEndDate: Date {
        Calendar.current.date(
            byAdding: .month,
            value: lease.termMonths,
            to: lease.startDate
        )!
    }
    
    /// Calculate total amount of days in the lease
    var totalLeaseDays: Int {
        let days = Calendar.current.dateComponents(
            [.day],
            from: lease.startDate,
            to: leaseEndDate
        ) .day ?? 0
        
        return max(days, 1)
    }
    
    /// Calculate allowed miles per day in lease
    var allowedMilesPerDay: Double {
        Double(totalMilesAllowed) / Double(totalLeaseDays)
    }
    
    /// Calculate current miles per day
    var currentMilesPerDay: Double {
        guard daysElapsed > 0 else { return 0 }
        return Double(lease.currentMileage) / Double(daysElapsed)
    }
    
    /// Calculate how many days have passed since lease start
    var daysElapsed: Int {
        let today = Date()
        
        let days = Calendar.current.dateComponents(
            [.day],
            from: lease.startDate,
            to: today
        ) .day ?? 0
        
        return max(0, min(days, totalLeaseDays))
    }
    
    /// Calculate how many days remain on the lease
    var daysRemaining: Int {
        max(totalLeaseDays - daysElapsed, 0)
    }
    
    /// Displays Pace status - 'Above, Below, Right on Pace'
    var dailyPaceStatusText: String {
        if currentMilesPerDay > allowedMilesPerDay {
            return "Above Pace"
        } else if currentMilesPerDay < allowedMilesPerDay {
            return "Below Pace"
        } else {
            return "Right on Pace"
        }
    }
    
    var expectedMileageByToday: Double {
        allowedMilesPerDay * Double(daysElapsed)
    }
    
    var differenceInMilesAllowed: Double {
        expectedMileageByToday - Double(lease.currentMileage)
    }
    
}

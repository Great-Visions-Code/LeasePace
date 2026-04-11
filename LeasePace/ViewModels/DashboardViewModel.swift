//
//  DashboardViewModel.swift
//  LeasePace
//
//  Created by Great-Visions-Code on 4/7/26
//

import Foundation
import Combine

/// Transforms raw `Vehicle` and `Lease` data into calculated values
/// for the dashboard screen.
///
/// This ViewModel is responsible for:
/// - Lease timeline calculations
/// - Daily mileage pacing calculations
/// - End-of-lease mileage projections
/// - Overage and under-mile forecasting
/// - Dashboard-friendly status text
final class DashboardViewModel: ObservableObject {
        
    let vehicle: Vehicle
    let lease: Lease
        
    init(vehicle: Vehicle, lease: Lease) {
        self.vehicle = vehicle
        self.lease = lease
    }
        
    // MARK: - Lease Allowance
        
    /// Total miles allowed for the full lease term.
    ///
    /// Example:
    /// - 12,000 miles/year
    /// - 36 month lease
    /// - total = 36,000 miles
    var totalMilesAllowed: Int {
        (lease.milesAllowedPerYear * lease.termMonths) / 12
    }
        
    // MARK: - Lease Dates
        
    /// The calculated lease end date based on the start date
    /// and lease term in months.
    var leaseEndDate: Date {
        Calendar.current.date(
            byAdding: .month,
            value: lease.termMonths,
            to: lease.startDate
        )!
    }
        
    /// Total number of days in the lease.
    ///
    /// Uses Calendar to safely account for real date differences,
    /// including leap years.
    var totalLeaseDays: Int {
        let days = Calendar.current.dateComponents(
            [.day],
            from: lease.startDate,
            to: leaseEndDate
        ).day ?? 0
            
        return max(days, 1)
    }
        
    /// Number of days that have passed since the lease started.
    ///
    /// Clamped between:
    /// - 0 if the lease has not started yet
    /// - totalLeaseDays if the lease has already ended
    var daysElapsed: Int {
        let today = Date()
            
        let days = Calendar.current.dateComponents(
            [.day],
            from: lease.startDate,
            to: today
        ).day ?? 0
            
        return max(0, min(days, totalLeaseDays))
    }
        
    /// Number of days remaining in the lease.
    var daysRemaining: Int {
        max(totalLeaseDays - daysElapsed, 0)
    }
        
    // MARK: - Daily Pace
        
    /// The allowed average miles per day for the full lease.
    var allowedMilesPerDay: Double {
        Double(totalMilesAllowed) / Double(totalLeaseDays)
    }
        
    /// The user's current average miles driven per day.
    ///
    /// Returns 0 if the lease has not started yet to avoid dividing by zero.
    var currentMilesPerDay: Double {
        guard daysElapsed > 0 else { return 0 }
        return Double(lease.currentMileage) / Double(daysElapsed)
    }
        
    // MARK: - Current Lease Position
        
    /// The number of miles the user would be expected to have driven by today
    /// if they were following the ideal lease pace exactly.
    var expectedMileageByToday: Double {
        allowedMilesPerDay * Double(daysElapsed)
    }
        
    /// Difference between expected mileage by today and actual current mileage.
    ///
    /// Positive value:
    /// - user is under allowance to date
    ///
    /// Negative value:
    /// - user is over allowance to date
    var differenceInMilesAllowedToDate: Double {
        expectedMileageByToday - Double(lease.currentMileage)
    }
        
    // MARK: - End-of-Lease Forecast
        
    /// Projected total mileage at lease end if the user continues
    /// driving at their current average daily pace.
    var projectedMilesAtEndOfLease: Double {
        currentMilesPerDay * Double(totalLeaseDays)
    }
        
    /// Miles projected over the total lease allowance at lease end.
    ///
    /// Clamped to 0 so it never returns a negative value.
    var projectedOverageMiles: Double {
        max(projectedMilesAtEndOfLease - Double(totalMilesAllowed), 0)
    }
        
    /// Miles projected under the total lease allowance at lease end.
    ///
    /// Clamped to 0 so it never returns a negative value.
    var projectedUnderMiles: Double {
        max(Double(totalMilesAllowed) - projectedMilesAtEndOfLease, 0)
    }
        
    /// Estimated dollar amount due at lease end for mileage overage.
    var projectedOverageCost: Double {
        projectedOverageMiles * lease.costPerMile
    }
        
    // MARK: - Dashboard Messaging
        
    /// Summary text describing the projected end-of-lease mileage outcome.
    var projectedMileageSummaryText: String {
        if projectedOverageMiles > 0 {
            return "You're projected to drive \(projectedOverageMiles.formattedTwoDecimal) more miles than allowed by the end of this lease."
        } else {
            return "You're projected to drive \(projectedUnderMiles.formattedTwoDecimal) fewer miles than allowed by the end of this lease."
        }
    }
        
    /// High-level pace status.
    var paceStatusText: String {
        if projectedOverageMiles > 0 {
            return "You're Over Pace"
        } else {
            return "You're On Pace"
        }
    }
        
    // MARK: - Lease Progress
        
    /// Lease progress as a decimal value between 0 and 1.
    ///
    /// Example:
    /// - 0.18 = 18%
    var leaseProgress: Double {
        guard totalLeaseDays > 0 else { return 0 }
        return Double(daysElapsed) / Double(totalLeaseDays)
    }
    
    /// Lease progress formatted as a whole-number percentage.
    var leaseProgressPercentage: Int {
        Int((leaseProgress * 100).rounded())
    }
}

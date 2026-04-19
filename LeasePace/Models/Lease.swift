//
//  Lease.swift
//  LeasePace
//
//  Created by Great-Visions-Code on 4/1/26
//

import Foundation
/// Stores the user-entered lease details needed for mileage pacing
/// and end-of-lease overage forecasting.
struct Lease {
    /// The date the lease began.
    var startDate: Date
    
    /// Lease length in months.
    var termMonths: Int
    
    /// Annual mileage allowance for the lease.
    var milesAllowedPerYear: Int
    
    /// Overage cost charged per mile above the lease allowance.
    var costPerMile: Double
    
    /// Current odometer reading for the leased vehicle.
    var currentMileage: Int
}

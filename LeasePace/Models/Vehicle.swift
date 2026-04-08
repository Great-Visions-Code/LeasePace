//
//  Vehicle.swift
//  LeasePace
//
//  Created by Great-Visions-Code on 4/1/26
//

import Foundation

struct Vehicle {
    var year: Int
    var make: String
    var model: String
    
    // User given Nickname for Vehicle
    var nickname: String?
    
    // Displays Nickname or returns year, make, model as default
    // Handles empty Nickname case
    var displayName: String {
        if let nickname = nickname?
            .trimmingCharacters(in: .whitespacesAndNewlines),
           !nickname.isEmpty {
            return nickname
        } else {
            return "\(year) \(make) \(model)"
        }
    }
}


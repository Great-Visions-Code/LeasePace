//  Formatters.swift
// LeasePace
//
// Created by Great-Visions-Code on 4/8/26
//

import Foundation

//  MARK: - Double Formatting
extension Double {
    /// Example: 33.8
    var formattedTwoDecimal: String {
        self.formatted(
            .number.precision(.fractionLength(0...2))
        )
    }
    
    /// Example: 8,782
    var formattedWholeNumber: String {
        self.formatted(
            .number.precision(.fractionLength(0))
        )
    }
    
    /// Example: $1,234.56
    var formattedCurrency: String {
        self.formatted(
            .currency(code: "USD")
        )
    }
}

//  MARK: Int Formatting

/// Example: 1,234
extension Int {
    var formattedWithCommas: String {
        self.formatted()
    }
}

// MARK: Date Formatting

/// Example: April 1, 2026
extension Date {
    var formattedDateShortString: String {
        self.formatted(
            date: .abbreviated,
            time: .omitted
        )
    }
}


//
//  Date+Extensions.swift
//  Volunteers
//
//  Created by Arkadiusz Skupień on 04/10/2025.
//

import SwiftUI

extension Date {
    func formatted(as format: String, timeZone: TimeZone = .current, locale: Locale = .init(identifier: "pl_PL")) -> String {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = timeZone
        dateFormatter.locale = locale
        
        return dateFormatter.string(from: self)
    }
}

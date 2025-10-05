//
//  HomeCalendarDayView.swift
//  Volunteers
//
//  Created by Arkadiusz Skupień on 04/10/2025.
//

import SwiftUI

struct HomeCalendarDayView: View {
    let date: Date
    let isSelected: Bool
    let hasEvent: Bool
    let isCurrentMonth: Bool
    
    private let calendar = Calendar.current
    
    var body: some View {
        VStack(spacing: 4) {
            Text("\(calendar.component(.day, from: date))")
                .font(.caption)
                .fontWeight(isSelected ? .bold : .regular)
                .foregroundColor(
                    isSelected ? .white :
                    isCurrentMonth ? .primary : .secondary
                )
            
            if hasEvent {
                Circle()
                    .fill(isSelected ? .white : .blue)
                    .frame(width: 4, height: 4)
            }
        }
        .frame(height: 32)
        .frame(maxWidth: .infinity)
        .background(isSelected ? .blue : .clear)
        .clipShape(.rect(cornerRadius: 8))
    }
}

//
//  HomeCalendarSection.swift
//  Volunteers
//
//  Created by Arkadiusz Skupień on 04/10/2025.
//

import SwiftUI

struct HomeCalendarSection: View {
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
        VStack(spacing: 12) {
            // Month and navigation
            HStack {
                Text(viewModel.polishMonthYear)
                    .font(.headline)
                    .fontWeight(.semibold)
                
                Spacer()
                
                HStack(spacing: 20) {
                    Button(action: { viewModel.moveMonth(by: -1) }) {
                        Image(systemName: "chevron.left")
                            .font(.caption)
                            .fontWeight(.bold)
                            .foregroundStyle(.blue)
                    }
                    
                    Button(action: { viewModel.moveMonth(by: 1) }) {
                        Image(systemName: "chevron.right")
                            .font(.caption)
                            .fontWeight(.bold)
                            .foregroundStyle(.blue)
                    }
                }
            }
            
            // Weekday headers
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 8) {
                ForEach(viewModel.weekdays, id: \.self) { day in
                    Text(day)
                        .font(.caption)
                        .fontWeight(.medium)
                        .foregroundStyle(Color.secondary)
                }
            }
            
            // Calendar days
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 8) {
                ForEach(viewModel.getDaysInMonth(), id: \.self) { date in
                    if let date = date {
                        HomeCalendarDayView(
                            date: date,
                            isSelected: viewModel.isSameDay(date, viewModel.selectedDate),
                            hasEvent: viewModel.hasEventOnDate(date),
                            isCurrentMonth: viewModel.isCurrentMonth(date)
                        )
                        .onTapGesture {
                            viewModel.selectedDate = date
                        }
                    } else {
                        Rectangle()
                            .foregroundStyle(.clear)
                    }
                }
            }
            .frame(height: 220, alignment: .top)
        }
        .padding()
        .background(.ultraThinMaterial)
        .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(.white.opacity(0.2), lineWidth: 1)
        )
        .clipShape(.rect(cornerRadius: 15))
    }
}

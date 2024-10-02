//
//  SelectedDayEvent.swift
//  TodayinHistory
//
//  Created by Mehmet Jiyan Atalay on 23.09.2024.
//

import SwiftUI

struct SelectedDayEventView: View {
    
    @State private var selectedDay = 0
    @State private var selectedMonth = 0
    @State private var selectedYear: Int?
    
    @State var showPage = true
    
    @State var page = 0
    
    @ObservedObject var viewmodel = SelectedDayEventViewModel()
    @State private var displayedDate: String = ""
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    VStack {
                        Text("Day")
                        Picker("Day", selection: $selectedDay) {
                            ForEach(0..<32) { day in
                                Text("\(day)")
                            }
                        }
                    }
                    
                    VStack {
                        Text("Month")
                        Picker("Month", selection: $selectedMonth) {
                            ForEach(0..<13) { month in
                                Text("\(month)")
                            }
                        }
                    }
                    
                    VStack {
                        Text("Year")
                        TextField("Year(optional)", value: $selectedYear, formatter: NumberFormatter())
                            .keyboardType(.numbersAndPunctuation)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(width: 125)
                    }
                }
                Button {
                    Task {
                        self.showPage = false
                        await viewmodel.downloadSelectedDayEvents(year: selectedYear, month: selectedMonth, day: selectedDay)
                        self.showPage = true
                        DispatchQueue.main.async {
                            viewmodel.hideButton = false
                        }
                        if let year = selectedYear {
                            displayedDate = "\(selectedDay >= 10 ? "" : "0")\(selectedDay.description).\(selectedMonth >= 10 ? "" : "0")\(selectedMonth.description).\(year.description)"
                        } else {
                            displayedDate = "\(selectedDay >= 10 ? "" : "0")\(selectedDay.description).\(selectedMonth >= 10 ? "" : "0")\(selectedMonth.description)"
                        }
                    }
                } label: {
                    Text("Show")
                }
                .buttonStyle(.borderedProminent)
                .tint(.black)
                .overlay(content: {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.white, lineWidth:2)
                    })
                
                if !viewmodel.events.isEmpty {
                    
                    if colorScheme == .dark {
                        Rectangle()
                            .fill(.white)
                            .frame(height: 3)
                            .padding(.vertical)
                    } else {
                        Rectangle()
                            .fill(.gray)
                            .frame(height: 3)
                            .padding(.vertical)
                    }
                    
                    Text(self.displayedDate)
                    
                    Button {
                        page += 1
                        Task {
                            
                            DispatchQueue.main.async {
                                self.showPage = false
                                self.viewmodel.hideButton = true
                            }
                            
                            await viewmodel.addEvent(year: selectedYear, month: selectedMonth, day: selectedDay, page: page)
                            self.showPage = true
                        }
                    } label: {
                        Text("Add")
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.black)
                    .overlay(content: {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.white, lineWidth:2)
                    })
                    .disabled(viewmodel.hideButton)
                    if showPage {
                        List(viewmodel.events.reversed()) { event in
                            Text(event.year + " : " + event.event)
                                .padding(.vertical)
                                .bold()
                        }
                    } else {
                        ProgressView()
                            .progressViewStyle(.circular)
                        Spacer()
                    }
                }
            }
        }
    }
}

#Preview {
    SelectedDayEventView()
}

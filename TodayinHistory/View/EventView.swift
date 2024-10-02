//
//  ContentView.swift
//  TodayinHistory
//
//  Created by Mehmet Jiyan Atalay on 22.09.2024.
//

import SwiftUI

struct EventView: View {
    
    @ObservedObject var viewmodel = EventViewModel()
    
    @State var page = 0
    @State var showPage: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Today in History")
                    .bold()
                    .font(.title)
                Text("\(viewmodel.getDay() >= 10 ? viewmodel.getDay().description : String(format: "%02d", viewmodel.getDay())).\(viewmodel.getMonth() >= 10 ? viewmodel.getMonth().description : String(format: "%02d", viewmodel.getMonth()))")
                    .font(.title2)
                    .bold()
                Button {
                    page += 1
                    Task {
                        DispatchQueue.main.async {
                            self.showPage = false
                            self.viewmodel.hideButton = true
                        }
                        
                        await viewmodel.addEvent(page: page)
                        
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
                        VStack {
                            Text(event.year + " : " + event.event)
                                .padding(.vertical)
                                .bold()
                        }
                    }
                } else {
                    ProgressView()
                        .progressViewStyle(.circular)
                    Spacer()
                }
                
            }
        }
        .onAppear {
            Task {
                self.showPage = false
                await viewmodel.downloadEvents()
                self.showPage = true
            }
        }
    }
}

#Preview {
    EventView()
}

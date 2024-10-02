//
//  TabView.swift
//  TodayinHistory
//
//  Created by Mehmet Jiyan Atalay on 23.09.2024.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            EventView()
                .tabItem {
                    Image(systemName: "clock")
                    Text("Today's Events")
                }
            SelectedDayEventView()
                .tabItem {
                    Image(systemName: "calendar")
                    Text("Select a Day")
                }
        }
        .tabViewStyle(.automatic)
    }
}

#Preview {
    MainView()
}

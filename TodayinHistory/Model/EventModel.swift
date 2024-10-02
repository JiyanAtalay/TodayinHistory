//
//  EventModel.swift
//  TodayinHistory
//
//  Created by Mehmet Jiyan Atalay on 22.09.2024.
//

import Foundation

struct EventModel: Codable, Identifiable {
    var id: UUID = UUID()
    let year: String
    let month: String
    let day: String
    let event: String
    
    enum CodingKeys: String, CodingKey {
        case year, month, day, event
    }
}

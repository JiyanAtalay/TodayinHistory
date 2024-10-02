//
//  WebService.swift
//  TodayinHistory
//
//  Created by Mehmet Jiyan Atalay on 22.09.2024.
//

import Foundation

public class WebService {
    func downloadEvent(url : URLRequest) async throws -> [EventModel] {
        do {
            let (data, response) = try await URLSession.shared.data(for: url)
            if let response = response as? HTTPURLResponse, response.statusCode == 200 {
                return try JSONDecoder().decode([EventModel].self, from: data)
            }
        } catch let DecodingError.dataCorrupted(context) {
            print("Data corrupted: \(context.debugDescription)")
        } catch let DecodingError.keyNotFound(key, context) {
            print("Key '\(key)' not found: \(context.debugDescription)")
        } catch let DecodingError.valueNotFound(value, context) {
            print("Value '\(value)' not found: \(context.debugDescription)")
        } catch let DecodingError.typeMismatch(type, context) {
            print("Type '\(type)' mismatch: \(context.debugDescription)")
        } catch {
            print("General decoding error: \(error.localizedDescription)")
        }
        
        return []
    }
}

//
//  EventViewModel.swift
//  TodayinHistory
//
//  Created by Mehmet Jiyan Atalay on 22.09.2024.
//

import Foundation

class EventViewModel : ObservableObject {
    @Published var events = [EventModel]()
    @Published var hideButton = false
    
    let webservice = WebService()
    
    func downloadEvents() async {
        do {
            if let urlRequest = Urls.doUrlWithoutYear(month: getMonth(), day: getDay(), offset: 0) {
                let data = try await webservice.downloadEvent(url: urlRequest)
                
                DispatchQueue.main.async {
                    self.events = data
                }
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func addEvent(page: Int) async {
        do {
            if let urlRequest = Urls.doUrlWithoutYear(month: getMonth(), day: getDay(), offset: page) {
                let data = try await webservice.downloadEvent(url: urlRequest)
                
                if events.last?.event != data.last?.event {
                    DispatchQueue.main.async {
                        if let last = data.last {
                            self.events.append(last)
                            self.hideButton = false
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        self.hideButton = true
                    }
                }
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func getDay() -> Int {
        let date = Date()
        let calendar = Calendar.current
        return calendar.component(.day, from: date)
    }
    
    func getMonth() -> Int {
        let date = Date()
        let calendar = Calendar.current
        return calendar.component(.month, from: date)
    }
}

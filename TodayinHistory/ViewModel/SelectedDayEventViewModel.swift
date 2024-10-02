//
//  SelectedDayEventViewModel.swift
//  TodayinHistory
//
//  Created by Mehmet Jiyan Atalay on 23.09.2024.
//

import Foundation

class SelectedDayEventViewModel: ObservableObject {
    @Published var events = [EventModel]()
    @Published var hideButton = true
    
    let webservice = WebService()
    
    func downloadSelectedDayEvents(year: Int?, month: Int, day: Int) async {
        do {
            let urlRequest : URLRequest?
            
            if let year {
                urlRequest = Urls.doUrlWithYear(year: year, month: month, day: day, offset: 0)
            } else {
                urlRequest = Urls.doUrlWithoutYear(month: month, day: day, offset: 0)
            }
            
            if let urlRequest {
                let data = try await webservice.downloadEvent(url: urlRequest)
                
                DispatchQueue.main.async {
                    self.events = data
                }
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func addEvent(year: Int?, month: Int, day: Int,page : Int) async {
        do {
            let urlRequest : URLRequest?
            
            if let year {
                urlRequest = Urls.doUrlWithYear(year: year, month: month, day: day, offset: page)
            } else {
                urlRequest = Urls.doUrlWithoutYear(month: month, day: day, offset: page)
            }
            
            if let urlRequest {
                let data = try await webservice.downloadEvent(url: urlRequest)
                
                if events.last?.event != data.last?.event && !data.isEmpty {
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
}

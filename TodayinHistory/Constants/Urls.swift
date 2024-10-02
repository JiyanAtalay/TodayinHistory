//
//  Urls.swift
//  TodayinHistory
//
//  Created by Mehmet Jiyan Atalay on 22.09.2024.
//

import Foundation

struct Urls {
    /*
    static func doUrl(day : Int) -> URLRequest? {
        let apiKey = ""
        let changedQuery = day.description.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let urlString = "https://api.calorieninjas.com/v1/historicalevents?text=\(changedQuery!)"
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return nil
        }
        
        var request = URLRequest(url: url)
        request.setValue(apiKey, forHTTPHeaderField: "X-Api-Key")
        
        return request
    }*/
    
    static func doUrlWithoutYear(month : Int,day : Int, offset : Int) -> URLRequest? {
        let textDay = "\(day)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let textMonth = "\(month)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let textOffset = "\(offset)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        let url = URL(string: "https://api.api-ninjas.com/v1/historicalevents?month=" + textMonth! + "&day=" + textDay! + "&offset=" + textOffset!)!
        var request = URLRequest(url: url)
        request.setValue("", forHTTPHeaderField: "X-Api-Key")
        
        return request
    }
    
    static func doUrlWithYear(year: Int, month : Int,day : Int, offset : Int) -> URLRequest? {
        let textDay = "\(day)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let textMonth = "\(month)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let textYear = "\(year)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let textOffset = "\(offset)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        let url=URL(string: "https://api.api-ninjas.com/v1/historicalevents?year=" + textYear! + "&month=" + textMonth! + "&day=" + textDay! + "&offset=" + textOffset!)!
        var request = URLRequest(url: url)
        request.setValue("", forHTTPHeaderField: "X-Api-Key")
        
        return request
    }
}

//
//  DailyWeatherRowViewModel.swift
//  SwiftUItest
//
//  Created by Kaikai Liu on 3/19/20.
//  Copyright © 2020 CMPE277. All rights reserved.
//

import Foundation

import SwiftUI
import MapKit
import Combine


let dayFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "dd"
    return formatter
}()

let monthFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "MMMM"
    return formatter
}()

struct DailyWeatherRowViewModel: Identifiable {
    
    private let item: WeeklyForecastResponse.Item
     //private let item1: CurrentWeatherForecastResponse
    
    var id: String {
        return day + temperature + title
    }
    
    var day: String {
        return dayFormatter.string(from: item.date)
    }
    
    var month: String {
        return monthFormatter.string(from: item.date)
    }
    
    var temperature: String {
        return String(format: "%.1f", item.main.temp)
    }
    
    var title: String {
        guard let title = item.weather.first?.main.rawValue else { return "" }
        return title
    }
    
    var fullDescription: String {
        guard let description = item.weather.first?.weatherDescription else { return "" }
        return description
    }
    
    //Added by Sheetal 04/13 to include weather icons in weekly report
    var icon: String {
        guard let icon = item.weather.first?.icon else { return "" }
        return icon
    }
    
//    var lon: String {
//        return String(item.coord.lon)
//    }
//    var lat: String {
//        return String(item.coord.lat)
//    }
    
    init(item: WeeklyForecastResponse.Item) {
        self.item = item
    }

}


// Used to hash on just the day in order to produce a single view model for each
// day when there are multiple items per each day.
extension DailyWeatherRowViewModel: Hashable {
    static func == (lhs: DailyWeatherRowViewModel, rhs: DailyWeatherRowViewModel) -> Bool {
        return lhs.day == rhs.day
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.day)
    }
}



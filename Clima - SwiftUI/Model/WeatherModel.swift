//
//  WeatherModel.swift
//  Clima - SwiftUI
//
//  Created by Maya Fenelon on 12/9/19.
//  Copyright © 2019 Maya Fenelon. All rights reserved.
//
import Foundation

struct WeatherModel {
    //identifying the types of constants we have 
    let conditionId: Int
    let cityName: String
    let temperature: Double
    let imageDescription: String
    
    var temperatureString: String{
        return String(format: "%.1f", temperature)
    }
    
    //switch that returns the name of the weather image when given the id
    var conditionName: String {
        switch conditionId {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 711:
            return "smoke"
        case 741:
            return "cloud.fog"
        case 781:
            return "tornado"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud"
        default:
            return "cloud"
        }
    }
}

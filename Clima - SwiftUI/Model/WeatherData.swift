//
//  WeatherData.swift
//  Clima - SwiftUI
//
//  Created by Maya Fenelon on 12/9/19.
//  Copyright © 2019 Maya Fenelon. All rights reserved.
//
import Foundation

//structure that mimics that from the openWeather website which contains the name of the city, a strucutre, and an array called weather
struct  WeatherData: Codable{
    let name: String
    let main: Main
    let weather: [Weather] //an array of weather
}

struct Main: Codable{
    let temp: Double
}

struct Weather: Codable { // this structure has the image id and the description of the  weather at that location 
    let id: Int
    let description: String 
}

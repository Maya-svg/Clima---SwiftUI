//
//  WeatherManager.swift
//  Clima - SwiftUI
//
//  Created by Maya Fenelon on 12/9/19.
//  Copyright © 2019 Maya Fenelon. All rights reserved.
//

import Foundation
import CoreLocation


class WeatherManager: ObservableObject {
    // all these variables are information that is displayed on the screen to the user
    @Published var cityName = "Boston"
    @Published var temperatureDegree = "21"
    @Published var weatherImage = "cloud"
    @Published var weatherDetail = "cloudy"
    
    let weatherUrl = "https://api.openweathermap.org/data/2.5/weather?appid=3171ef8b85625faa354b923a0da791cc&units=imperial"
    
    func fetchingWeather(cityName: String) {
        //takes the cityName that was typed in the TextField and adds a %20 if there is a space (if the city name is 2 words)
       let urlSafeCityName = cityName.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        //inputs that new variable into the official url string
        let urlString = "\(weatherUrl)&q=\(urlSafeCityName!)" // cityName is self.locationName
        //url is then used to search for the weather at that location
        performRequest(with: urlString)
        
}

    func fetchingWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        //function that uses the latitude and longitude of the user's location in the url when searching for the weather
        let urlString = "\(weatherUrl)&lat=\(latitude)&lon=\(longitude)"
        print(urlString)
        ///url is then used to search for the weather uses the previously created url
        performRequest(with: urlString)
    }
    
    func performRequest (with urlString: String){
        // these are the 4 steps to NETWORKING
        //(sending information elsewhere and retriving the results)
        // Step 1. creates an (optional) url ---this is a structure
        if let url = URL(string: urlString){
            // step 2. create a URL session
            //like a browser --- it has the ability to process the url
            let session = URLSession(configuration: .default)
            //step3. give the sesion a task
            //uses the url is the one we just completed
            let task = session.dataTask(with: url) /*takes a function as an input*/ { ( data, response, error)  in //this is a closure
                // the task triggers this function --- if there is a problem we are notified.
                if error != nil {
                    print(error!)
                    return // stops fuction
                }
                //checks the data we got back
                if let safeData = data{
                    self.parseJSON(weatherData: safeData)
                    //(safeData turns into a string) let dataString = String(data: safeData, encoding: .utf8) utf8 is the format of the data we get back from the web
                }
            } //returns a task --- means grabbing the information from the website and bringing it back
            //step 4. Start the task
            task.resume() //this starts the task
        }
    }
    
    func parseJSON(weatherData: Data){
        let decoder = JSONDecoder()
        do {
            let decodedData =  try decoder.decode(WeatherData.self, from: weatherData)
          //selecting first weather structure if multiple and finding the Id in that array and inputing that number in variable Id
            let id = decodedData.weather[0].id
            //variable temperature is taken from the structure main on the website
            let temp = decodedData.main.temp
            //the name of the city is decoded using this line
            let name = decodedData.name
            //the variable description is filled from the description aspect of the weather structure
            let description = decodedData.weather[0].description
            //the cityName is displayed by taking the name of the location on the website
            cityName = decodedData.name
           //weather variable is the weather Model that contains these 4 aspects
                // the constant oditionId is stored as Id, cityname as name, temperature as temp and imagedescription as description 
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp, imageDescription: description)
            //these next three lines are where the displayed aspects are updated as they are changed.
            weatherDetail = weather.imageDescription
            weatherImage = weather.conditionName 
            temperatureDegree = weather.temperatureString
        } catch{
            //if something goes wrong then an "erroe" message is prompted 
            print (error)
        }
    }
}

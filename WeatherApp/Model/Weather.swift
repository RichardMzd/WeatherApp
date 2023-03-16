//
//  Weather.swift
//  WeatherApp
//
//  Created by Richard Arif Mazid on 14/03/2023.
//

import Foundation

// MARK: - Welcome
struct MainWeather: Decodable {
    let weather: [Weather]
    let main: Main
    let name: String
    
}

// MARK: - Main
struct Main: Decodable {
    let temp, feelsLike, tempMin, tempMax: Double
    let pressure, humidity: Int
    
    var tempCelsius: Double {
           return temp - 273.15
       }

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure, humidity
    }
}

// MARK: - Weather
struct Weather: Decodable {
    let id: Int
    let main, description, icon: String
}


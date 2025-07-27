//
//  WeatherModel.swift
//  Weather_App
//
//  Created by Aryan Jain on 23/07/25.
//

import Foundation

struct WttrResponse: Codable {
    let currentCondition: [CurrentCondition]
    let nearestArea: [NearestArea]
    
    enum CodingKeys: String, CodingKey {
        case currentCondition = "current_condition"
        case nearestArea = "nearest_area"
    }
}

struct CurrentCondition: Codable {
    let tempC: String
    let feelsLikeC: String
    let humidity: String
    let pressure: String
    let windspeedKmph: String
    let winddir16Point: String
    let visibility: String
    let cloudcover: String
    let uvIndex: String
    let weatherDesc: [WeatherDescription]
    let weatherCode: String
    let localObsDateTime: String
    
    enum CodingKeys: String, CodingKey {
        case tempC = "temp_C"
        case feelsLikeC = "FeelsLikeC"
        case humidity
        case pressure
        case windspeedKmph
        case winddir16Point
        case visibility
        case cloudcover
        case uvIndex
        case weatherDesc
        case weatherCode
        case localObsDateTime
    }
}

struct WeatherDescription: Codable {
    let value: String
}

struct NearestArea: Codable {
    let areaName: [AreaName]
    let country: [Country]
    
    enum CodingKeys: String, CodingKey {
        case areaName
        case country
    }
}

struct AreaName: Codable {
    let value: String
}

struct Country: Codable {
    let value: String
}

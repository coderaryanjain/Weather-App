//
//  WeatherService.swift
//  Weather_App
//
//  Created by Aryan Jain on 23/07/25.
//

import Foundation

class WeatherService {
    
    func fetchWeather(for city: String) async throws -> WttrResponse {
        let urlString = "https://wttr.in/\(city)?format=j1"
        let url = URL(string: urlString)!
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let weather = try JSONDecoder().decode(WttrResponse.self, from: data)
        
        return weather
    }
}

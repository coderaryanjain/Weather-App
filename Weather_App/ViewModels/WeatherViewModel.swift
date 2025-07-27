//
//  WeatherViewModel.swift
//  Weather_App
//
//  Created by Aryan Jain on 24/07/25.
//

import Foundation
import SwiftUI

@MainActor
class WeatherViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published var weather: WttrResponse?
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var searchText = ""
    
    // MARK: - Private Properties
    private let weatherService = WeatherService()
        
    // MARK: - Public Methods
    func searchWeather() {
        guard !searchText.isEmpty else {
            errorMessage = "Please enter a city name"
            return
        }
        
        let cityToSearch = searchText // Store the search term
        searchText = "" // Clear search text immediately on search
        isLoading = true
        errorMessage = nil
        
        Task {
            do {
                let weatherData = try await weatherService.fetchWeather(for: cityToSearch)
                await MainActor.run {
                    self.weather = weatherData
                    self.isLoading = false
                }
            } catch {
                await MainActor.run {
                    self.errorMessage = "Could not find weather for this city"
                    self.isLoading = false
                }
            }
        }
    }
    
    
    // MARK: - Computed Properties
    var gradientColors: [Color] {
        guard let weather = weather,
              let condition = weather.currentCondition.first else {
            return [Color.blue, Color.purple, Color.pink]
        }
        
        let weatherCode = condition.weatherCode
        
        switch weatherCode {
        case "113": // Sunny/Clear
            return [Color.yellow, Color.orange, Color.red]
        case "116", "119", "122": // Cloudy
            return [Color.blue, Color.cyan, Color.white]
        case "176", "293", "296", "302", "308": // Rain
            return [Color.blue, Color.indigo, Color.gray]
        case "179", "323", "326", "332", "338": // Snow
            return [Color.white, Color.blue, Color.cyan]
        case "200", "386", "389": // Thunder
            return [Color.black, Color.purple, Color.blue]
        default:
            return [Color.blue, Color.purple, Color.pink]
        }
    }
    
    var isSearchButtonEnabled: Bool {
        !searchText.isEmpty && !isLoading
    }
    
}

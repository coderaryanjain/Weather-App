//
//  WeatherView.swift
//  Weather_App
//
//  Created by Aryan Jain on 23/07/25.
//

import SwiftUI

// MARK: - Main Weather View
struct WeatherView: View {
    @StateObject private var viewModel = WeatherViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                // Dynamic Weather-Based Background
                LinearGradient(
                    gradient: Gradient(colors: viewModel.gradientColors),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                .animation(.easeInOut(duration: 1.5), value: viewModel.gradientColors)
                
                ScrollView {
                    VStack(spacing: 25) {
                        // Combined Search Bar (previously SearchBarView + SearchButtonView)
                        HStack(spacing: 15) {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.white.opacity(0.7))
                                .font(.system(size: 18, weight: .medium))
                            
                            TextField("Search for a city...", text: $viewModel.searchText)
                                .textFieldStyle(PlainTextFieldStyle())
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(.white)
                                .accentColor(.white)
                            
                            // Inline Search Button Logic
                            if viewModel.isLoading {
                                ProgressView()
                                    .scaleEffect(0.8)
                                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            } else {
                                Button(action: viewModel.searchWeather) {
                                    Image(systemName: "arrow.right.circle.fill")
                                        .font(.system(size: 24, weight: .medium))
                                        .foregroundColor(.white)
                                }
                                .scaleEffect(viewModel.isSearchButtonEnabled ? 1.0 : 0.8)
                                .opacity(viewModel.isSearchButtonEnabled ? 1.0 : 0.5)
                                .animation(.spring(response: 0.3, dampingFraction: 0.6), value: viewModel.isSearchButtonEnabled)
                                .disabled(!viewModel.isSearchButtonEnabled)
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 16)
                        .background(
                            RoundedRectangle(cornerRadius: 25)
                                .fill(.ultraThinMaterial)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 25)
                                        .stroke(.white.opacity(0.2), lineWidth: 1)
                                )
                        )
                        .padding(.horizontal, 20)
                        .padding(.top, 10)
                        
                        // Content Area
                        WeatherContentView(viewModel: viewModel)
                    }
                    .padding(.bottom, 20)
                }
            }
            .navigationBarHidden(true)
            .onSubmit {
                viewModel.searchWeather()
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

// MARK: - Combined Content & Weather Info View
struct WeatherContentView: View {
    @ObservedObject var viewModel: WeatherViewModel
    @State private var animateCards = false
    
    var body: some View {
        Group {
            if viewModel.isLoading {
                // Inline Loading View
                VStack(spacing: 20) {
                    ZStack {
                        Circle()
                            .stroke(.white.opacity(0.3), lineWidth: 8)
                            .frame(width: 80, height: 80)
                        
                        Circle()
                            .trim(from: 0, to: 0.7)
                            .stroke(.white, style: StrokeStyle(lineWidth: 8, lineCap: .round))
                            .frame(width: 80, height: 80)
                            .rotationEffect(.degrees(animateCards ? 360 : 0))
                            .animation(.linear(duration: 1.0).repeatForever(autoreverses: false), value: animateCards)
                    }
                    
                    Text("Getting weather data...")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundColor(.white.opacity(0.8))
                        .opacity(animateCards ? 1.0 : 0.6)
                        .animation(.easeInOut(duration: 1.0).repeatForever(autoreverses: true), value: animateCards)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .onAppear { animateCards = true }
                .transition(AnyTransition.scale.combined(with: .opacity))
                
            } else if let weather = viewModel.weather {
                // Combined Weather Info Display
                WeatherDisplayView(weather: weather, isAnimated: animateCards)
                    .transition(.asymmetric(
                        insertion: AnyTransition.move(edge: .bottom).combined(with: .opacity),
                        removal: AnyTransition.move(edge: .top).combined(with: .opacity)
                    ))
                    .onAppear {
                        withAnimation { animateCards = true }
                    }
                    .onDisappear { animateCards = false }
                    
            } else {
                // Inline Welcome View
                VStack(spacing: 25) {
                    Image(systemName: "cloud.sun.fill")
                        .font(.system(size: 100, weight: .thin))
                        .foregroundColor(.white)
                        .scaleEffect(animateCards ? 1.0 : 0.8)
                        .opacity(animateCards ? 1.0 : 0.6)
                        .animation(.spring(response: 0.8, dampingFraction: 0.6).delay(0.2), value: animateCards)
                    
                    VStack(spacing: 15) {
                        Text("Welcome to Weather")
                            .font(.system(size: 28, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                            .scaleEffect(animateCards ? 1.0 : 0.8)
                            .opacity(animateCards ? 1.0 : 0.0)
                            .animation(.spring(response: 0.6, dampingFraction: 0.8).delay(0.4), value: animateCards)
                        
                        Text("Search for any city to get real-time weather information with beautiful visuals")
                            .font(.system(size: 16, weight: .medium))
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white.opacity(0.8))
                            .padding(.horizontal, 30)
                            .scaleEffect(animateCards ? 1.0 : 0.8)
                            .opacity(animateCards ? 1.0 : 0.0)
                            .animation(.spring(response: 0.6, dampingFraction: 0.8).delay(0.6), value: animateCards)
                    }
                }
                .padding(40)
                .background(
                    RoundedRectangle(cornerRadius: 30)
                        .fill(.ultraThinMaterial)
                        .overlay(
                            RoundedRectangle(cornerRadius: 30)
                                .stroke(.white.opacity(0.2), lineWidth: 1)
                        )
                )
                .padding(.horizontal, 20)
                .onAppear { animateCards = true }
                .transition(AnyTransition.scale.combined(with: .opacity))
            }
        }
    }
}

// MARK: - Combined Weather Display (Main Card + Details Grid)
struct WeatherDisplayView: View {
    let weather: WttrResponse
    let isAnimated: Bool
    
    var body: some View {
        VStack(spacing: 20) {
            if let currentCondition = weather.currentCondition.first,
               let area = weather.nearestArea.first {
                
                // Combined Main Weather Card
                VStack(spacing: 20) {
                    Text("\(area.areaName.first?.value ?? "Unknown"), \(area.country.first?.value ?? "Unknown")")
                        .font(.system(size: 28, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .scaleEffect(isAnimated ? 1.0 : 0.8)
                        .opacity(isAnimated ? 1.0 : 0.0)
                        .animation(.spring(response: 0.6, dampingFraction: 0.8).delay(0.1), value: isAnimated)
                    
                    VStack(spacing: 8) {
                        Text("\(currentCondition.tempC)°")
                            .font(.system(size: 80, weight: .ultraLight, design: .rounded))
                            .foregroundColor(.white)
                            .scaleEffect(isAnimated ? 1.0 : 0.5)
                            .opacity(isAnimated ? 1.0 : 0.0)
                            .animation(.spring(response: 0.8, dampingFraction: 0.6).delay(0.2), value: isAnimated)
                        
                        Text(currentCondition.weatherDesc.first?.value ?? "")
                            .font(.system(size: 20, weight: .medium, design: .rounded))
                            .foregroundColor(.white.opacity(0.9))
                            .scaleEffect(isAnimated ? 1.0 : 0.8)
                            .opacity(isAnimated ? 1.0 : 0.0)
                            .animation(.spring(response: 0.6, dampingFraction: 0.8).delay(0.3), value: isAnimated)
                        
                        Text("Feels like \(currentCondition.feelsLikeC)°")
                            .font(.system(size: 16, weight: .regular))
                            .foregroundColor(.white.opacity(0.8))
                            .scaleEffect(isAnimated ? 1.0 : 0.8)
                            .opacity(isAnimated ? 1.0 : 0.0)
                            .animation(.spring(response: 0.6, dampingFraction: 0.8).delay(0.4), value: isAnimated)
                    }
                }
                .padding(.vertical, 30)
                .padding(.horizontal, 20)
                .background(
                    RoundedRectangle(cornerRadius: 30)
                        .fill(.ultraThinMaterial)
                        .overlay(
                            RoundedRectangle(cornerRadius: 30)
                                .stroke(.white.opacity(0.2), lineWidth: 1)
                        )
                )
                .padding(.horizontal, 20)
                
                // Combined Weather Details Grid
                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 15), count: 2), spacing: 15) {
                    let details = [
                        ("humidity", "Humidity", "\(currentCondition.humidity)%"),
                        ("wind", "Wind Speed", "\(currentCondition.windspeedKmph) km/h"),
                        ("location.north", "Direction", currentCondition.winddir16Point),
                        ("gauge", "Pressure", "\(currentCondition.pressure) hPa"),
                        ("eye", "Visibility", "\(currentCondition.visibility) km"),
                        ("cloud", "Cloud Cover", "\(currentCondition.cloudcover)%"),
                        ("sun.max", "UV Index", currentCondition.uvIndex),
                        ("clock", "Updated", formatTime(currentCondition.localObsDateTime))
                    ]
                    
                    ForEach(Array(details.enumerated()), id: \.offset) { index, detail in
                        // Inline Weather Detail Card
                        VStack(spacing: 12) {
                            Image(systemName: detail.0)
                                .font(.system(size: 24, weight: .medium))
                                .foregroundColor(.white.opacity(0.9))
                            
                            VStack(spacing: 4) {
                                Text(detail.1)
                                    .font(.system(size: 12, weight: .medium))
                                    .foregroundColor(.white.opacity(0.7))
                                
                                Text(detail.2)
                                    .font(.system(size: 16, weight: .semibold))
                                    .foregroundColor(.white)
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 100)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(.ultraThinMaterial)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(.white.opacity(0.2), lineWidth: 1)
                                )
                        )
                        .scaleEffect(isAnimated ? 1.0 : 0.8)
                        .opacity(isAnimated ? 1.0 : 0.0)
                        .animation(.spring(response: 0.6, dampingFraction: 0.8).delay(0.5 + Double(index) * 0.1), value: isAnimated)
                        .onTapGesture {
                            let impactFeedback = UIImpactFeedbackGenerator(style: .light)
                            impactFeedback.impactOccurred()
                        }
                    }
                }
                .padding(.horizontal, 20)
            }
        }
    }
    
    private func formatTime(_ timeString: String) -> String {
        if let timeRange = timeString.range(of: #"\d{2}:\d{2} [AP]M"#, options: .regularExpression) {
            return String(timeString[timeRange])
        }
        return timeString
    }
}

#Preview {
    WeatherView()
}

//
//  WeeklyWeatherView.swift
//  SwiftUItest
//
//  Created by Kaikai Liu on 3/19/20.
//  Copyright © 2020 CMPE277. All rights reserved.
//

import SwiftUI
import Foundation
import Combine

struct WeeklyWeatherView: View {
    @ObservedObject var viewModel: WeeklyWeatherViewModel
    
    @ObservedObject var locationViewModel = LocationViewModel()
    

    init(viewModel: WeeklyWeatherViewModel) {
        self.viewModel = viewModel
    }
    
    
    var body: some View {
        //Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//        HStack {
//            if viewModel.dataSource.isEmpty {
//                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//                //emptySection
//            } else {
//                Text("Results: " + viewModel.displayWeatherInfo())
//            }
//        }
        
        NavigationView {
            List {
               
                VStack(alignment: .center) {
                    //TextField("e.g. Cupertino", text: $viewModel.city)
                    
                    Text("\(locationViewModel.placemark?.locality ?? "No city location")")
                        .font(.title).fontWeight(.light)
                    
                    Text("Location Latitude: \(locationViewModel.userLongitude), Longitude: \(locationViewModel.userLongitude)")
                        .padding([.leading, .trailing])
                        .font(.subheadline)
                    
                    
                    currentLocationWeatherViewSection
                }
                
                Section {
                    ZStack(alignment: .trailing){
                        TextField("Search other cities, e.g. Cupertino", text: $viewModel.city, onEditingChanged: { (changed) in
                            print("City onEditingChanged - \(changed)")
                            //gets called when user taps on the TextField or taps return. The changed value is set to true when user taps on the TextField and it’s set to false when user taps return.
                        }) {
                            //The onCommit callback gets called when user taps return.
                            print("City onCommit")
                            //self.viewModel.fetchWeather(forCity: self.viewModel.city)
                        }
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        ActivityIndicator(shouldAnimate: $viewModel.activityshouldAnimate)
                    }
                }
                
                if viewModel.dataSource.isEmpty {
                    Section {
                        Text("No results")
                            .foregroundColor(.blue)
                    }
                } else {
//                    Section(content: content)
//                        .onAppear(perform: currentviewModel.refresh)
//                        .navigationBarTitle(viewModel.city)
//                        .listStyle(GroupedListStyle())
//                    List(content: content)
//                    .onAppear(perform: currentviewModel.refresh)
//                    .navigationBarTitle(viewModel.city)
//                    .listStyle(GroupedListStyle())
                    currentWeatherViewSection //show current WeatherView
                    Section {
                        ForEach(viewModel.dataSource, content: DailyWeatherRow.init(viewModel:))
                    }
                }
                
            }
            .listStyle(GroupedListStyle())
            .navigationBarTitle("Weather ⛅️")
            
        }
    }
}


struct DailyWeatherRow: View {
    private let viewModel: DailyWeatherRowViewModel
    
    init(viewModel: DailyWeatherRowViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        HStack {
            VStack {
                Text("\(viewModel.day)")
                Text("\(viewModel.month)")
                    
            }
            
            VStack(alignment: .leading) {
                Text("\(viewModel.title)")
                    .font(.body)
                Text("\(viewModel.fullDescription)")
                    .font(.footnote)
            }
            .padding(.leading, 8)
            //Added by Sheetal 04/13 call method to get weather icon from url
            getWeatherSymbol(icon: "\(viewModel.icon)")
            Spacer()
            
            Text("\(viewModel.temperature)°")
                .font(.title)
                
        //Added by Sheetal 04/13 to update UI
        }.background(Color.blue)
        .foregroundColor(.white)
        .cornerRadius(5)
        .padding()
    }
}

//New added for current weather view
private extension WeeklyWeatherView {
    var currentWeatherViewSection: some View {
        Section {
            //viewModel.currentWeatherView
            NavigationLink(destination: viewModel.currentWeatherView) //Using WeeklyWeatherBuilder.makeCurrentWeatherView
            {
                VStack(alignment: .leading) {
                    Text(viewModel.city)
                    Text("Weather today")
                        .font(.caption)
                        .foregroundColor(.blue)
                }
            }
        }
    }
}

//New added for current location weather view
private extension WeeklyWeatherView {
    var currentLocationWeatherViewSection: some View {
        Section {
            //viewModel.currentWeatherView
            NavigationLink(destination: viewModel.currentLocationWeatherView) //Using WeeklyWeatherBuilder.makeCurrentWeatherView
            {
                VStack(alignment: .leading) {
                    Text(locationViewModel.placemark?.locality ?? "No city location")
                    Text("Weather in current place today")
                        .font(.caption)
                        .foregroundColor(.blue)
                }
            }
        }
    }
}

struct WeeklyWeatherView_Previews: PreviewProvider {
    //let datafetchpreview = DataFetcher()
    
    static var previews: some View {
        let weeklyviewModel = WeeklyWeatherViewModel(weatherFetcher: DataFetcher())
        
        //
        //let currentviewModel = CurrentWeatherViewModel(weatherFetcher: DataFetcher(), ci
        //let currentviewModel = CurrentWeatherViewModel(city: "San Jose", weatherFetcher: DataFetcher())
        return WeeklyWeatherView(viewModel: weeklyviewModel)
    }
}

//Added By Sheetal on 04/10 to display weather icons
func getWeatherSymbol(icon: String) -> Image? {
  switch icon {
    case "200":
        return Image(systemName: "cloud.bolt.rain.fill")
    case "01d":
        return Image(systemName: "sun.max.fill")
    case "02d":
        return Image(systemName: "cloud.sun")
    case "03d":
        return Image(systemName: "cloud.fill")
    case "04d":
        return Image(systemName: "smoke.fill")
    case "09d":
        return Image(systemName: "cloud.rain.fill")
    case "10d":
        return Image(systemName: "cloud.rain.fill")
    case "11d":
        return Image(systemName: "cloud.bolt.fill")
    case "13d":
        return Image(systemName: "snow")
    case "50d":
        return Image(systemName: "mist")
    case "01n":
        return Image(systemName: "sun.max.fill")
    case "02n":
        return Image(systemName: "cloud.sun")
    case "03n":
        return Image(systemName: "cloud.fill")
    case "04n":
        return Image(systemName: "smoke.fill")
    case "09n":
        return Image(systemName: "cloud.rain.fill")
    case "10n":
        return Image(systemName: "cloud.bolt.rain.fill")
    case "11n":
        return Image(systemName: "cloud.bolt.fill")
    case "13n":
        return Image(systemName: "snow")
    case "50n":
        return Image(systemName: "mist")
    default:
        return Image(systemName: "sun.min")
   }
}



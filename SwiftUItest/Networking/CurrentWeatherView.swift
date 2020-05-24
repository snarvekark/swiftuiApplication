//
//  CurrentWeatherView.swift
//  SwiftUItest
//
//  Created by Kaikai Liu on 3/20/20.
//  Copyright © 2020 CMPE277. All rights reserved.
//

import SwiftUI

struct CurrentWeatherView: View {
    @ObservedObject var viewModel: CurrentWeatherViewModel

    init(viewModel: CurrentWeatherViewModel) {
      self.viewModel = viewModel
    }
    
    var body: some View {
        VStack{
            HStack {
                Image(systemName: "cloud.sun.rain")
                    .resizable()
                    .frame(width: CGFloat(40), height: CGFloat(40))
                
                Text(viewModel.city)
                    .font(.title)
                    .fontWeight(.light)
                   
            }
            List(content: content)
                .onAppear(perform: viewModel.refresh)
                .navigationBarTitle(viewModel.city)
                .listStyle(GroupedListStyle())
        //Added by Sheetal 04/13 to update UI
        }.background(Color.yellow)
        .foregroundColor(.white)
        .cornerRadius(5)
        .padding()
    
    }
}

//New added for current weather view
private extension CurrentWeatherView {
    func content() -> some View {
        if let currentviewModel = viewModel.dataSource {
            return AnyView(details(for: currentviewModel))
        } else {
            return AnyView(loading)
        }
    }
    
    func details(for viewModel: CurrentWeatherRowViewModel) -> some View {
        CurrentWeatherRow(viewModel: viewModel)
    }
    
    var loading: some View {
        Text("Loading \(viewModel.city)'s weather...")
            .foregroundColor(.blue)
    }
}

struct CurrentWeatherRow: View {
    private let viewModel: CurrentWeatherRowViewModel
    
    init(viewModel: CurrentWeatherRowViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            
            HStack {
                Text("\(viewModel.temperature)°")
                .font(.system(size: 50))
                .fontWeight(.ultraLight)

                VStack(alignment: .leading) {
                HStack {
                    Text("📈 Max temperature:")
                    Spacer()
                    Text("\(viewModel.maxTemperature)°")
                    }.padding(.bottom, 1)
                
                HStack {
                    Text("📉 Min temperature:")
                    Spacer()
                    Text("\(viewModel.minTemperature)°")
                    }.padding(.bottom, 1)
                    
                HStack {
                Text("🕡 Pressure:")
                Spacer()
                Text("\(viewModel.pressure)")
                }.padding(.bottom, 1)   
                
                HStack {
                    Text("💧 Humidity:")
                    Spacer()
                    Text(viewModel.humidity)
                    }.padding(.bottom, 1)
                }.font(.caption)
                
                
            }.foregroundColor(.black)
            
            VStack(alignment: .leading)
            {
            
            MapView(coordinate: viewModel.coordinate)
                .cornerRadius(25)
                .frame(height: 300)
                .disabled(true)
                
            }
            
            VStack(alignment: .leading) {
                HStack {
                    Text("☀️ Temperature:")
                    Text("\(viewModel.temperature)°")
                        //.foregroundColor(.blue)
                }
                
                HStack {
                    Text("📈 Max temperature:")
                    Text("\(viewModel.maxTemperature)°")
                        //.foregroundColor(.blue)
                }
                
                HStack {
                    Text("📉 Min temperature:")
                    Text("\(viewModel.minTemperature)°")
                        //.foregroundColor(.blue)
                }
                //Added by Sheetal 04/13 to display Pressure
                HStack {
                   Text("🕡 Pressure:")
                   Text("\(viewModel.pressure)")
                   //.foregroundColor(.blue)
                }
                
                HStack {
                    Text("💧 Humidity:")
                    Text(viewModel.humidity)
                        //.foregroundColor(.blue)
                }
            //Added By Sheetal to update UI on 04/13
            }.background(Color.yellow)
            .foregroundColor(.white)
            .cornerRadius(5)
            .padding()
        }
    }
}

struct CurrentWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        let currentviewModel = CurrentWeatherViewModel(city: "San Jose", weatherFetcher: DataFetcher())
        return CurrentWeatherView(viewModel: currentviewModel)
    }
}

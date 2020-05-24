//
//  Home.swift
//  SwiftUItest
//
//  Created by Kaikai Liu on 3/13/20.
//  Copyright © 2020 CMPE277. All rights reserved.
//

import SwiftUI

struct CategoryHome: View {
    @State var showingProfile = false
    @EnvironmentObject var userData: UserData
    
    var categories: [String: [DataItem]] {
        Dictionary(
            grouping: sampleDataItem,
            by: { $0.category.rawValue }
        )
    }
    
    var featured: [DataItem] {
        sampleDataItem.filter{$0.isFeatured}
    }
    
    var profileButton: some View {
        Button(action: { self.showingProfile.toggle() }) {
            Image(systemName: "person.crop.circle")
                .imageScale(.large)
                .accessibility(label: Text("User Profile"))
                .padding()
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                FeaturedDataItems(dataitems: featured)
                    .scaledToFill()
                    .frame(height: 200)
                    .clipped()
                    .listRowInsets(EdgeInsets())
                
                ForEach(categories.keys.sorted(by: <), id: \.self) { key in
                    CategoryRow(categoryName: key, items: self.categories[key]!)
                }
                .listRowInsets(EdgeInsets())
                
//                if (userData.isLandscape)
//                {
//                    ForEach(categories.keys.sorted(), id: \.self) { key in
//                        CategoryRow(categoryName: key, items: self.categories[key]!)
//                    }
//                    .listRowInsets(EdgeInsets())
//                }else {
//                    ForEach(categories.keys.sorted(), id: \.self) { key in
//                        CategoryRow(categoryName: key, items: self.categories[key]!)
//                    }
//                    .listRowInsets(EdgeInsets())
//                }
                
//                NavigationLink(destination: LandmarkList()) {
//                    Text("See All")
//                }
            }
            .navigationBarTitle(Text("Featured"))
            .navigationBarItems(trailing: profileButton)
            .sheet(isPresented: $showingProfile) {
                ProfileHost()
                    .environmentObject(self.userData)
            }
        }
    }
}

struct FeaturedDataItems: View {
    var dataitems: [DataItem]
    var body: some View {
        dataitems[0].image.resizable()
    }
}

struct CategoryHome_Previews: PreviewProvider {
    static var previews: some View {
        CategoryHome().environmentObject(UserData())
    }
}

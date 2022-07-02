//
//  ContentView.swift
//  GoSwift
//
//  Created by Siamak Ashrafi on 6/15/22.
//
//  dependence injection with needle
import SwiftUI

struct ContentView: View {
    
    var body: some View {
        VStack() {
            TabView {
                BikeMapView()
                    .tabItem {
                        Label("Bikes", systemImage: "bicycle.circle.fill")
                    }
                BikeListView()
                    .tabItem {
                        Label("events", systemImage: "calendar")
                    }
            }
        }
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

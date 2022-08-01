//
//  ChartPagingView.swift
//  GoSwift
//
//  Created by Siamak Ashrafi on 7/29/22.
//

import SwiftUI

struct ChartPagingView: View {
    @StateObject var healthVM : HealthViewModel
    
    var body: some View {
        TabView {
            ChartStepsView(healthVM: healthVM)
                .tabItem { Text("Steps") }
            
            ChartBikeMilesView(healthVM: healthVM)
                .tabItem { Text("Bike") }
            
            ChartHeartHealthView()
                .tabItem { Text("Heart") }

            VStack {
                Text("Doing Good! Keep Working Out").font(.largeTitle).padding()
                Image(systemName: "face.smiling.fill")
                    .resizable()
                    .frame(width: 150, height: 150)
                    .foregroundColor(.yellow)
            } .tabItem { Text("My Little Friend") }
            
        }
        .tabViewStyle(PageTabViewStyle())  //  or DefaultTabViewStyle() to show tabs
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
    }
}

struct ChartPagingView_Previews: PreviewProvider {
    
    static var healthVM = HealthViewModel(
        getAllHealtInfo: Resolver.shared.resolve(GetHealthInfoUseCaseProtocol.self)
    )
    
    
    static var previews: some View {
        ChartPagingView(healthVM:healthVM)
    }
}

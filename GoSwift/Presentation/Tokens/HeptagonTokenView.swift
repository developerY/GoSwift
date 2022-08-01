//
//  HeptagonTokenView.swift
//  GoSwift
//
//  Created by Siamak Ashrafi on 7/31/22.
//

import SwiftUI


struct HeptagonTokenView: View {
    @State private var rotation = 0.0
    @State private var number = 119.0
    var body: some View {
       
        VStack {
            
            ZStack() {
               
                Heptagon().fill(.linearGradient(Gradient(colors: [Self.gradientStart, Self.gradientEnd]), startPoint: UnitPoint(x: 0.5, y: 0), endPoint: UnitPoint(x:0.5,y:0.6)))
                    .rotationEffect(.degrees(rotation),anchor: .center)
                    .shadow(radius: 7)
                    //.frame(width: rotation,height: rotation)
                VStack() {
                    Text("Tokens").font(.title).padding()
                    Text("\(Int(number * (rotation/733.0)))").font(.largeTitle)
                }
                
            }
            Spacer()
            
        }.onAppear {
            Task {
                for turn in 1...733 {
                    rotation = Double(turn)
                    try await Task.sleep(nanoseconds: 10_000_000)
                }
            
            }
        }
    }
    
    static let gradientStart = Color(red: 239.0 / 255, green: 120.0 / 255, blue: 221.0 / 255)
    static let gradientEnd = Color(red: 239.0 / 255, green: 172.0 / 255, blue: 120.0 / 255)

   
}

struct HeptagonTokenView_Previews: PreviewProvider {
    static var previews: some View {
        HeptagonTokenView()
    }
}

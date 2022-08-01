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
    let degreesRotation :Double = 733.0

    var body: some View {
       
        VStack {
            
            ZStack() {
               
                Heptagon().fill(.linearGradient(Gradient(colors: [Self.gradientStart, Self.gradientEnd]), startPoint: UnitPoint(x: 0.5, y: 0), endPoint: UnitPoint(x:0.5,y:0.9)))
                    .rotationEffect(.degrees(rotation),anchor: .center)
                    .shadow(radius: 7)
                    .frame(width: 151,height: 151)
                Text(
                    Image(systemName: "bolt.circle.fill")
                        .renderingMode(.original)
                )
                    .rotationEffect(.degrees(-rotation),anchor: .center)
                    .opacity(rotation/degreesRotation)
                    
                VStack() {
                    Text("NFT")
                        .font(.title)
                        .padding()
                
                    Text("\(Int(number * (rotation/degreesRotation)))").font(.largeTitle)
                }
                
            }
            Spacer()
            
        }.onAppear {
            Task {
                for turn in 1...Int(degreesRotation) {
                    rotation = Double(turn)
                    try await Task.sleep(nanoseconds: 10_000_000)
                }
            
            }
        }
    }
    
    static let gradientStart = Color(red: 192.0 / 255, green: 178.0 / 255, blue: 243.0 / 255)
    static let gradientEnd = Color(red: 150.0 / 255, green: 202.0 / 255, blue: 247.0 / 255)

   
}

struct HeptagonTokenView_Previews: PreviewProvider {
    static var previews: some View {
        HeptagonTokenView()
    }
}

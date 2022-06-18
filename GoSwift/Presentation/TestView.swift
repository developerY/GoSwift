//
//  TestView.swift
//  GoSwift
//
//  Created by Siamak Ashrafi on 6/16/22.
//

import Foundation
import SwiftUI


struct ExampleView: View {
    @State private var width: CGFloat = 50
    
    var body: some View {
        VStack {
            SubView()
                .frame(width: self.width, height: 120)
                .border(Color.blue, width: 2)
            
            Text("Offered Width \(Int(width))")
            Slider(value: $width, in: 0...200, step: 1)
        }
    }
}


struct SubView: View {
    var body: some View {
        GeometryReader { proxy in
            Rectangle()
                .fill(Color.yellow.opacity(0.7))
                .frame(width: max(proxy.size.width, 120), height: max(proxy.size.height, 120))
        }
    }
}


struct ExampleView_Previews: PreviewProvider {
    static var previews: some View {
        ExampleView()
    }
}



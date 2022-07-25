//
//  CreditCardView.swift
//  GoSwift
//
//  Created by Siamak Ashrafi on 7/4/22.
//
// Copid from - Credit https://azamsharp.medium.com/credit-card-entry-interface-in-swiftui-using-binding-rotation-effect-and-gradients-bad1f206cf7e

import SwiftUI

struct CreditCardView: View {
    @State private var degrees: Double = 0
    @State private var flipped: Bool = false
    
    @State private var name: String = ""
    @State private var expires: String = ""
    @State private var cvv: String = ""
    
    var body: some View {
        VStack {
            CreditCard {
                
                VStack {
                    Group {
                        if flipped {
                            CreditCardBack(cvv: cvv)
                        } else {
                            CreditCardFront(name: name, expires: expires)
                        }
                    }
                }.rotation3DEffect(
                    .degrees(degrees),
                    axis: (x: 0.0, y: 1.0, z: 0.0)
                )
                
            }
            .onTapGesture {
                withAnimation {
                    degrees += 180
                    flipped.toggle()
                }
            }
            
            TextField("Name", text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding([.top,.leading,.trailing])
            
            TextField("Expiration", text: $expires)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding([.leading,.trailing])
            
            TextField("CVV", text: $cvv) { (editingChanged) in
                withAnimation {
                    degrees += 180
                    flipped.toggle()
                }
            } onCommit: {}
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding([.leading,.trailing])
            
        }
    }
}

struct CreditCardView_Previews: PreviewProvider {
    static var previews: some View {
        CreditCardView()
    }
}

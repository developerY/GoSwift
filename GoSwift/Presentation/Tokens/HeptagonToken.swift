//
//  HeptagonToken.swift
//  GoSwift
//
//  Created by Siamak Ashrafi on 7/31/22.
//

import Foundation

//TODO: Add inner shadows simulate depth with SwiftUI and Core Motion from Paul Hudson.

import CoreGraphics
import SwiftUI

struct Heptagon : Shape {
    var sides  = 7
  
    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x:rect.width / 2 , y: rect.height / 2)
        
        let radius = rect.width / 2
        
        let angle = Double.pi * 2 / Double(sides)
        
        var path = Path()
        var startPoint = CGPoint(x:0,y:0)
        
        for side in 0 ..< sides {
            let x = center.x + (cos(Double(side) * angle) * radius)
            let y = center.y + (sin(Double(side) * angle) * radius)
            let vertexPoint = CGPoint(x:x, y:y)
            
            if (side == 0) {
                startPoint = vertexPoint
                path.move(to: startPoint)
            } else {
                path.addLine(to: vertexPoint)
            }
            
            if (side == (sides - 1)) {
                path.addLine(to: startPoint)
            }
            
        }
        return path
    }
    
}
    

//
//  Polar.swift
//  Mandala
//
//  Created by Katalin Neda on 21/10/2019.
//  Copyright © 2019 Katalin Neda. All rights reserved.
//

import UIKit

class Polar {
    
    let radius: CGFloat
    var angle: CGFloat
    var point: CGPoint {
        get {
            let x = radius * cos(angle)
            let y = radius * sin(angle)
            return CGPoint(x: x, y: y)
        }
    }
    
    init(radius: CGFloat, angle: CGFloat) {
        self.radius = radius
        self.angle = angle
    }
    
    init(point: CGPoint) {
        radius = point.polar().radius
        angle = point.polar().angle
    }
    
}

extension CGPoint {
    
    func polar() -> Polar {
        let radius = sqrt(x*x + y*y)
        var angle = atan(y/x)
        
        if x<0 {
            angle += CGFloat.pi
        }
        
        return Polar(radius: radius, angle: angle)
    }
    
}


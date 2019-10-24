//
//  Point.swift
//  Mandala
//
//  Created by Katalin Neda on 21/10/2019.
//  Copyright © 2019 Katalin Neda. All rights reserved.
//

import UIKit

func +(lhs: CGPoint, rhs: CGPoint) -> CGPoint {
    return CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
}

//func +=(lhs: inout CGPoint, rhs: CGPoint) {
//    lhs = lhs + rhs
//}

func -(lhs: CGPoint, rhs: CGPoint) -> CGPoint {
    return CGPoint(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
}

//func -=(lhs: inout CGPoint, rhs: CGPoint) {
//    lhs = lhs - rhs
//}

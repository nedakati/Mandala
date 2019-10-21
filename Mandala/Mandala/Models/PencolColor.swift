//
//  Color.swift
//  DrawPad
//
//  Created by Katalin Neda on 18/10/2019.
//  Copyright © 2019 Ray Wenderlich. All rights reserved.
//

import UIKit

enum PencilColor {
    case black
    case white
    case blue
    case orange
    case yellow
    case purple
    case green
    case red
    case pink
    
    static let allValues = [black, white, blue, orange, yellow, purple, green, red, pink]
    
    var color: UIColor {
        switch self {
        case .black: return .black
        case .white: return .white
        case .blue: return UIColor(red: 41/255, green: 128/255, blue: 185/255, alpha: 1)
        case .orange: return UIColor(red: 243/255, green: 156/255, blue: 18/255, alpha: 1)
        case .yellow: return UIColor(red: 241/255, green: 196/255, blue: 15/255, alpha: 1)
        case .purple: return UIColor(red: 142/255, green: 68/255, blue: 173/255, alpha: 1)
        case .green: return UIColor(red: 46/255, green: 204/255, blue: 113/255, alpha: 1)
        case .red: return UIColor(red: 192/255, green: 57/255, blue: 43/255, alpha: 1)
        case .pink: return UIColor(red: 233/255, green: 30/255, blue: 90/255, alpha: 1)
        }
    }
}

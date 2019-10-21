//
//  ColorCollectionViewLayout.swift
//  DrawPad
//
//  Created by Katalin Neda on 18/10/2019.
//  Copyright © 2019 Ray Wenderlich. All rights reserved.
//

import UIKit

class ColorCollectionViewLayout: UICollectionViewFlowLayout {
    
    override init() {
        super.init()
        scrollDirection = .horizontal
        minimumLineSpacing = 20
        sectionInsetReference = .fromSafeArea
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func invalidateLayout() {
        super.invalidateLayout()
        itemSize = CGSize(width: 50, height: 50)
    }
}

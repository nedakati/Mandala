//
//  ColorCell.swift
//  DrawPad
//
//  Created by Katalin Neda on 18/10/2019.
//  Copyright © 2019 Ray Wenderlich. All rights reserved.
//

import UIKit

class ColorCell: UICollectionViewCell {
    
    private var colorView: UIView!
    
    var pencilColor: PencilColor? {
        didSet {
            colorView.backgroundColor = pencilColor?.color
        }
    }
    
    override init(frame: CGRect = .zero) {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        colorView.layer.cornerRadius = colorView.bounds.height / 2
        colorView.layer.borderColor = UIColor.black.cgColor
        colorView.layer.borderWidth = 1
    }
    
    private func setupView() {
        colorView = UIView()
        colorView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(colorView)
        
        NSLayoutConstraint.activate([
            colorView.bottomAnchor.constraint(equalTo: bottomAnchor),
            colorView.topAnchor.constraint(equalTo: topAnchor),
            colorView.leadingAnchor.constraint(equalTo: leadingAnchor),
            colorView.trailingAnchor.constraint(equalTo: trailingAnchor)
            ])
    }
}

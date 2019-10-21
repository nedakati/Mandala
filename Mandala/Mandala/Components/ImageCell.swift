//
//  ImageCell.swift
//  DrawPad
//
//  Created by Katalin Neda on 18/10/2019.
//  Copyright © 2019 Ray Wenderlich. All rights reserved.
//

import UIKit

class ImageCell: UICollectionViewCell {
    
    private var imageView: UIImageView!
    
    override init(frame: CGRect = .zero) {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        imageView = UIImageView()
        imageView.image = UIImage(named: "arrow")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor)
            ])
    }
}

//
//  ColorsView.swift
//  DrawPad
//
//  Created by Katalin Neda on 18/10/2019.
//  Copyright © 2019 Ray Wenderlich. All rights reserved.
//

import UIKit

protocol ColorViewDelegate: AnyObject {
    func didSelectColor(_ color: PencilColor)
    func hideColors()
}

class ColorsView: UIView {
    
    // MARK: - Private properties
    
    private var collectionView: UICollectionView!
    
    // MARK: - Properties
    
    weak var delegate: ColorViewDelegate?
    
    // MARK: - Init
    
    override init(frame: CGRect = .zero) {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    func presentColors() {
        let cells = collectionView.visibleCells.sorted(by: { $0.frame.minY < $1.frame.minY})
        for cell in cells {
            cell.transform = CGAffineTransform(translationX: 90, y: 0)
        }
        collectionView.isHidden = false
        
        var index = 0
        for cell in cells {
            UIView.animate(withDuration: 0.1 * Double(PencilColor.allValues.count), delay: 0.1 * Double(index), usingSpringWithDamping:  0.7, initialSpringVelocity: 0, options: [.transitionCurlDown, .curveEaseOut], animations: {
                cell.transform = CGAffineTransform(translationX: 0, y: 0)
            }, completion: nil)
            index += 1
        }
    }
    
    func hideColors() {
        let cells = collectionView.visibleCells.sorted(by: { $0.frame.minY < $1.frame.minY})
        var index = 0
        for cell in cells {
            UIView.animate(withDuration: 0.1 * Double(PencilColor.allValues.count), delay: 0.1 * Double(index), usingSpringWithDamping:  0.7, initialSpringVelocity: 0, options: [.curveEaseIn], animations: {
                cell.transform = CGAffineTransform(translationX: 100, y: 0)
            }, completion: nil)
            index += 1
        }
        collectionView.isHidden = true
    }
    
    // MARK: - Private methods
    
    private func setupView() {
        backgroundColor = UIColor.clear.withAlphaComponent(0.2)
        
        let collectionViewLayout = ColorCollectionViewLayout()
        collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: collectionViewLayout)
        collectionView.register(ColorCell.self, forCellWithReuseIdentifier: "ColorCell")
        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: "ImageCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isHidden = true
        addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            collectionView.topAnchor.constraint(equalTo: topAnchor, constant: 24),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor)
            ])
    }
}

// MARK: - UICollectionViewDataSource

extension ColorsView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return PencilColor.allValues.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == PencilColor.allValues.count {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as? ImageCell else { return UICollectionViewCell() }
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ColorCell", for: indexPath) as? ColorCell else { return UICollectionViewCell() }
            cell.pencilColor = PencilColor.allValues[indexPath.row]
            return cell
        }
    }
}

// MARK: - UICollectionViewDelegate

extension ColorsView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == PencilColor.allValues.count {
            delegate?.hideColors()
        } else {
            delegate?.didSelectColor(PencilColor.allValues[indexPath.row])
        }
    }
}

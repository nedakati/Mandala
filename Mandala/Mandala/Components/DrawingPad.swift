//
//  DrawingPad.swift
//  Mandala
//
//  Created by Katalin Neda on 21/10/2019.
//  Copyright © 2019 Katalin Neda. All rights reserved.
//

import UIKit

protocol DrawingPadDelegate: AnyObject {
    func touchBegan()
}

class DrawingPad: UIImageView {
    
    // MARK: - Properties
    
    public var pencilColor: PencilColor = .black
    public var pencilWidth: CGFloat = 10
    public var pencilOpacity: CGFloat = 1
    public var numberOfPhases: Int = 8

    public var lines: [Line] = []
    public weak var delegate: DrawingPadDelegate?

    // MARK: - Private properties
    
    private var imageView: UIImageView!
    private var beforePreviousPoint: CGPoint = .zero
    private var previous: CGPoint = .zero
    private var currentPoint: CGPoint = .zero
    private var images: [UIImage] = []
    
    // MARK: - Init
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    // MARK: - Public methods
    
    public func reset() {
        imageView.image = nil
        image = nil
    }

    // MARK: - Touch events
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        delegate?.touchBegan()
        beforePreviousPoint = touch.previousLocation(in: self)
        previous = touch.previousLocation(in: self)
        currentPoint = touch.location(in: self)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        
        beforePreviousPoint = previous
        previous = touch.previousLocation(in: self)
        currentPoint = touch.location(in: self)
        draw(for: Path(beforePreviousPoint: beforePreviousPoint, previousPoint: previous, currentPoint: currentPoint))
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIGraphicsBeginImageContext(frame.size)
        image?.draw(in: bounds, blendMode: .normal, alpha: 1.0)
        imageView.image?.draw(in: imageView.bounds, blendMode: .normal, alpha: pencilOpacity)
        image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        imageView.image = nil
    }
    
    // MARK: - Drawing methods
    
    private func draw(for path: Path) {
        
        let paths = drawLines(for: path)
        
        UIGraphicsBeginImageContext(imageView.frame.size)
        imageView.image?.draw(in: imageView.frame)
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        for path in paths {
            let middle = middleOf(path.beforePreviousPoint, path.previousPoint)
            let middle1 = middleOf(path.previousPoint, path.currentPoint)
            context.move(to: middle)
            context.addQuadCurve(to: middle1, control: path.previousPoint)
        }
        
        context.setLineWidth(pencilWidth)
        context.setStrokeColor(pencilColor.color.cgColor)
        context.setBlendMode(.normal)
        context.setLineCap(.round)
        context.strokePath()
        
        imageView.image = UIGraphicsGetImageFromCurrentImageContext()
        imageView.alpha = pencilOpacity
        UIGraphicsEndImageContext()
    }
    
    // MARK: - Private methods
    
    private func drawLines(for path: Path) -> [Path] {
        
        var paths: [Path] = []
        let angle = 2 * CGFloat.pi / CGFloat(numberOfPhases)
        
        let center = imageView.center
        
        let beforeLastPolarPoint = (path.beforePreviousPoint - center).polar()
        let lastPolarPoint = (path.previousPoint - center).polar()
        let currentPolarPoint = (path.currentPoint - center).polar()
        
        let path = Path(beforePreviousPoint: beforeLastPolarPoint.point + center,
                        previousPoint: lastPolarPoint.point + center,
                        currentPoint: currentPolarPoint.point + center)
        paths.append(path)
        
        // MAIN LINES
        
        for _ in 0..<numberOfPhases {
            beforeLastPolarPoint.angle += angle
            lastPolarPoint.angle += angle
            currentPolarPoint.angle += angle
            let path = Path(beforePreviousPoint: beforeLastPolarPoint.point + center,
                            previousPoint: lastPolarPoint.point + center,
                            currentPoint: currentPolarPoint.point + center)
            paths.append(path)
        }
        
        // MIRRORED LINES:
        
        beforeLastPolarPoint.angle = angle + angle - beforeLastPolarPoint.angle
        lastPolarPoint.angle = angle + angle - lastPolarPoint.angle
        currentPolarPoint.angle = angle + angle - currentPolarPoint.angle
        
        for _ in 0..<numberOfPhases {
            beforeLastPolarPoint.angle += angle
            lastPolarPoint.angle += angle
            currentPolarPoint.angle += angle
            let path = Path(beforePreviousPoint: beforeLastPolarPoint.point + center,
                            previousPoint: lastPolarPoint.point + center,
                            currentPoint: currentPolarPoint.point + center)
            paths.append(path)
        }
        
        return paths
    }
    
    private func middleOf(_ point1: CGPoint, _ point2: CGPoint) -> CGPoint {
        return CGPoint(x: (point1.x + point2.x) / 2, y: (point1.y + point2.y) / 2)
    }
    
    private func setupView() {
        isUserInteractionEnabled = true

        imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}

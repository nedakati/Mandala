//
//  BrushView.swift
//  DrawPad
//
//  Created by Katalin Neda on 19/10/2019.
//  Copyright © 2019 Ray Wenderlich. All rights reserved.
//

import UIKit

enum SliderViewType {
    case brush
    case opacity
}

protocol SliderViewDelegate: AnyObject {
    func hideBrushView()
    func didChangeBrushSize(to value: CGFloat)
    func didChangeOpacity(to value: CGFloat)
}

class SliderView: UIView {
    
    // MARK: - Private properties
    
    private var slider: UISlider!
    private var previewView: UIView!
    private var hideButton: UIButton!
    private var previewViewWidth: NSLayoutConstraint!
    private var previewViewHeight: NSLayoutConstraint!
    
    private let sliderHeight: CGFloat = 300
    private let type: SliderViewType
    
    weak var delegate: SliderViewDelegate?
    var selectedColor: UIColor = .black {
        didSet {
            slider.maximumTrackTintColor = selectedColor
            previewView.backgroundColor = selectedColor
        }
    }
    
    // MARK: - Init
    
    init(type: SliderViewType) {
        self.type = type
        super.init(frame: .zero)
        setupView()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        previewView.layer.cornerRadius = previewView.bounds.height / 2
    }
    
    // MARK: - Private methods
    
    private func setupView() {
        backgroundColor = UIColor.clear.withAlphaComponent(0.2)
        
        slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.minimumValue = 0.1
        slider.maximumValue = 1
        slider.value = type == .brush ? 0.2 : 1
        slider.minimumTrackTintColor = .gray
        slider.maximumTrackTintColor = .black
        slider.thumbTintColor = UIColor(red: 41/255, green: 128/255, blue: 185/255, alpha: 1)
        slider.addTarget(self, action: #selector(didChangeSliderValue), for: .valueChanged)
        addSubview(slider)
        
        slider.transform = CGAffineTransform(rotationAngle: CGFloat(-Double.pi)/2)
        slider.isUserInteractionEnabled = true
        
        previewView = UIView()
        previewView.translatesAutoresizingMaskIntoConstraints = false
        previewView.backgroundColor = .black
        addSubview(previewView)
        
        hideButton = UIButton()
        hideButton.translatesAutoresizingMaskIntoConstraints = false
        hideButton.setImage(UIImage(named: "arrow"), for: .normal)
        hideButton.addTarget(self, action: #selector(hide), for: .touchUpInside)
        addSubview(hideButton)
        
        previewViewWidth = previewView.widthAnchor.constraint(equalToConstant: 24)
        previewViewHeight = previewView.heightAnchor.constraint(equalToConstant: 24)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            previewView.bottomAnchor.constraint(equalTo: slider.topAnchor, constant: -sliderHeight/2 - 24),
            previewView.centerXAnchor.constraint(equalTo: centerXAnchor),
            previewViewWidth,
            previewViewHeight,
            
            slider.widthAnchor.constraint(equalToConstant: sliderHeight),
            slider.centerXAnchor.constraint(equalTo: centerXAnchor),
            slider.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            hideButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -24),
            hideButton.widthAnchor.constraint(equalToConstant: 48),
            hideButton.heightAnchor.constraint(equalToConstant: 48),
            hideButton.centerXAnchor.constraint(equalTo: centerXAnchor)
            ])
    }
    
    @objc private func hide() {
        delegate?.hideBrushView()
    }
    
    @objc private func didChangeSliderValue() {
        if type == .brush {
            let brushSize: CGFloat = CGFloat(slider.value * 48)
            previewViewHeight.constant = brushSize
            previewViewWidth.constant = brushSize
            layoutSubviews()
            delegate?.didChangeBrushSize(to: brushSize)
        } else {
            previewView.alpha = CGFloat(slider.value)
            delegate?.didChangeOpacity(to: CGFloat(slider.value))
        }
    }
}

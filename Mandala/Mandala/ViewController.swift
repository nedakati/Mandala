//
//  ViewController.swift
//  Mandala
//
//  Created by Katalin Neda on 21/10/2019.
//  Copyright © 2019 Katalin Neda. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Private properties
    
    private var colorsView: ColorsView!
    private var colorsButton: UIButton!
    private var buttonsStackView: UIStackView!
    private var resetButton: UIButton!
    private var brushButton: UIButton!
    private var opacityButton: UIButton!
    private var brushView: SliderView!
    private var opacityView: SliderView!
    private var containerView: UIView!
    
    private var drawingPad: DrawingPad!
    
    private var selectedColor: UIColor = .black
    
    private var lastPoint = CGPoint.zero
    private let maximumBrushSize: CGFloat = 48.0
    private var brushWidth: CGFloat = 10.0
    private var opacity: CGFloat = 1.0
    private var swiped = false
    
    // MARK: - Lifecycle
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        brushView.layer.cornerRadius = 20
        brushView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
        brushView.clipsToBounds = true
        
        colorsView.layer.cornerRadius = 20
        colorsView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
        colorsView.clipsToBounds = true
        
        opacityView.layer.cornerRadius = 20
        opacityView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
        opacityView.clipsToBounds = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupConstraints()
    }
    
    // MARK: - Private methods
    
    private func setupView() {
        view.backgroundColor = UIColor(red: 242/255, green: 198/255, blue: 192/255, alpha: 1)
        
        containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = .white
        view.addSubview(containerView)
        
        drawingPad = DrawingPad()
        drawingPad.translatesAutoresizingMaskIntoConstraints = false
        drawingPad.delegate = self
        drawingPad.contentMode = .scaleToFill
        containerView.addSubview(drawingPad)
        
        buttonsStackView = UIStackView()
        buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonsStackView.alignment = .top
        buttonsStackView.distribution = .equalSpacing
        buttonsStackView.axis = .horizontal
        buttonsStackView.spacing = 20
        view.addSubview(buttonsStackView)
        
        colorsButton = UIButton()
        colorsButton.translatesAutoresizingMaskIntoConstraints = false
        colorsButton.setBackgroundImage(UIImage(named: "colors"), for: .normal)
        colorsButton.addTarget(self, action: #selector(didTapOnColorButton), for: .touchUpInside)
        buttonsStackView.addArrangedSubview(colorsButton)
        
        resetButton = UIButton()
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        resetButton.setBackgroundImage(UIImage(named: "reset"), for: .normal)
        resetButton.addTarget(self, action: #selector(didTapOnResetButton), for: .touchUpInside)
        buttonsStackView.addArrangedSubview(resetButton)
        
        brushButton = UIButton()
        brushButton.translatesAutoresizingMaskIntoConstraints = false
        brushButton.setBackgroundImage(UIImage(named: "brush"), for: .normal)
        brushButton.addTarget(self, action: #selector(didTapOnBrushButton), for: .touchUpInside)
        buttonsStackView.addArrangedSubview(brushButton)
        
        opacityButton = UIButton()
        opacityButton.translatesAutoresizingMaskIntoConstraints = false
        opacityButton.setBackgroundImage(UIImage(named: "opacity"), for: .normal)
        opacityButton.addTarget(self, action: #selector(didTapOnOpcityButton), for: .touchUpInside)
        buttonsStackView.addArrangedSubview(opacityButton)
        
        colorsView = ColorsView()
        colorsView.translatesAutoresizingMaskIntoConstraints = false
        colorsView.delegate = self
        colorsView.isHidden = true
        colorsView.transform = CGAffineTransform(translationX: 100, y: 0)
        view.addSubview(colorsView)
        
        brushView = SliderView(type: .brush)
        brushView.translatesAutoresizingMaskIntoConstraints = false
        brushView.isHidden = true
        brushView.transform = CGAffineTransform(translationX: 70, y: 0)
        brushView.selectedColor = selectedColor
        brushView.delegate = self
        view.addSubview(brushView)
        
        opacityView = SliderView(type: .opacity)
        opacityView.translatesAutoresizingMaskIntoConstraints = false
        opacityView.isHidden = true
        opacityView.transform = CGAffineTransform(translationX: 70, y: 0)
        opacityView.selectedColor = selectedColor
        opacityView.delegate = self
        view.addSubview(opacityView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            containerView.bottomAnchor.constraint(equalTo: buttonsStackView.topAnchor, constant: -24),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            
            drawingPad.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            drawingPad.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            drawingPad.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            drawingPad.topAnchor.constraint(equalTo: containerView.topAnchor),
            
            buttonsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            buttonsStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonsStackView.heightAnchor.constraint(equalToConstant: 48),
            
            colorsButton.widthAnchor.constraint(equalToConstant: 48),
            colorsButton.heightAnchor.constraint(equalToConstant: 48),
            resetButton.widthAnchor.constraint(equalToConstant: 48),
            resetButton.heightAnchor.constraint(equalToConstant: 48),
            brushButton.widthAnchor.constraint(equalToConstant: 48),
            brushButton.heightAnchor.constraint(equalToConstant: 48),
            opacityButton.heightAnchor.constraint(equalToConstant: 48),
            opacityButton.widthAnchor.constraint(equalToConstant: 48),
            
            colorsView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            colorsView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            colorsView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            colorsView.widthAnchor.constraint(equalToConstant: 100),
            
            brushView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            brushView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            brushView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            brushView.widthAnchor.constraint(equalToConstant: 70),
            
            opacityView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            opacityView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            opacityView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            opacityView.widthAnchor.constraint(equalToConstant: 70)
            ])
    }
    
    private func hideViews() {
        if !brushView.isHidden {
            UIView.animate(withDuration: 0.5, animations: {
                self.brushView.transform = CGAffineTransform(translationX: 70, y: 0)
            }) { _ in
                self.brushView.isHidden = true
            }
        }
        if !colorsView.isHidden {
            UIView.animate(withDuration: 0.5, animations: {
                self.colorsView.transform = CGAffineTransform(translationX: 100, y: 0)
            }) { _ in
                self.colorsView.hideColors()
                self.colorsView.isHidden = true
            }
        }
        if !opacityView.isHidden {
            UIView.animate(withDuration: 0.5, animations: {
                self.opacityView.transform = CGAffineTransform(translationX: 100, y: 0)
            }) { _ in
                self.opacityView.isHidden = true
            }
        }
    }
    
    // MARK: - UI Action methods
    
    @objc private func didTapOnColorButton() {
        hideViews()
        self.colorsView.isHidden = false
        UIView.animate(withDuration: 0.5, animations: {
            self.colorsView.transform = CGAffineTransform(translationX: 0, y: 0)
        }) { _ in
            self.colorsView.presentColors()
        }
    }
    
    @objc private func didTapOnResetButton() {
        hideViews()
        drawingPad.reset()
    }
    
    @objc private func didTapOnBrushButton() {
        hideViews()
        brushView.isHidden = false
        UIView.animate(withDuration: 0.5) {
            self.brushView.transform = CGAffineTransform(translationX: 0, y: 0)
        }
    }
    
    @objc private func didTapOnOpcityButton() {
        hideViews()
        opacityView.isHidden = false
        UIView.animate(withDuration: 0.5) {
            self.opacityView.transform = CGAffineTransform(translationX: 0, y: 0)
        }
    }
}

// MAKR: - ColorViewDelegate

extension ViewController: ColorViewDelegate {
    
    func didSelectColor(_ color: PencilColor) {
        selectedColor = color.color
        drawingPad.pencilColor = color
        brushView.selectedColor = color.color
        opacityView.selectedColor = color.color
    }
    
    func hideColors() {
        hideViews()
    }
}


extension ViewController: SliderViewDelegate {
    
    func didChangeOpacity(to value: CGFloat) {
        opacity = value
        drawingPad.pencilOpacity = value
    }
    
    func didChangeBrushSize(to value: CGFloat) {
        brushWidth = value
        drawingPad.pencilWidth = value
    }
    
    func hideBrushView() {
        hideViews()
    }
}

extension ViewController: DrawingPadDelegate {
    
    func touchBegan() {
        hideViews()
    }
}

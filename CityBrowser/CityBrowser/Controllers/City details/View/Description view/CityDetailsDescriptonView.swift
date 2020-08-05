//
//  CityDetailsDescriptonView.swift
//  CityBrowser
//
//  Created by Mateusz Popiało on 04/08/2020.
//  Copyright © 2020 Mateusz Popiało. All rights reserved.
//

import UIKit

class CityDetailsDescriptonView: UIView {
    
    enum C {
        static let highlightedColor: UIColor = UIColor.lightGray.withAlphaComponent(0.3)
        static let cornerRadius: CGFloat = 8
        static let margin: CGFloat = 15
    }
    
    enum AuxViewMode {
        case activityIndicator
        case detailsIndicator
        case none
    }
    
    //MARK: - Properties
    private let containerView: UIView = {
        let container = UIView()
        container.layer.cornerRadius = C.cornerRadius
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let auxViewContainer: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    fileprivate let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    private var currentMode: AuxViewMode? = nil
    
    //MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setup
    private func setupView() {
        setupContainerView()
        setupAuxView()
        setupDescriptionLabel()
        setupTitleLabel()
    }
    
    private func setupContainerView() {
        self.addSubview(containerView)
        NSLayoutConstraint.activate([
             containerView.topAnchor.constraint(equalTo: topAnchor),
             containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
             containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
             containerView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    private func setupAuxView() {
        self.addSubview(auxViewContainer)
        NSLayoutConstraint.activate([
            auxViewContainer.topAnchor.constraint(equalTo: containerView.topAnchor),
            auxViewContainer.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            auxViewContainer.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        ])
    }
    
    private func setupDescriptionLabel() {
        self.addSubview(descriptionLabel)
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: C.margin),
            descriptionLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: C.margin),
            descriptionLabel.trailingAnchor.constraint(equalTo: auxViewContainer.leadingAnchor)
        ])
    }
    
    private func setupTitleLabel() {
        self.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 0),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: C.margin),
            titleLabel.trailingAnchor.constraint(equalTo: auxViewContainer.leadingAnchor, constant: 0),
            titleLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -C.margin)
        ])
    }
    
    //MARK: - Configuration
    public func configure(withTitle title: String, description: String, mode: AuxViewMode) {
        descriptionLabel.text = description
        titleLabel.text = title
        
        if let currentMode = currentMode, currentMode == mode {
            return
        }
        self.currentMode = mode
        
        auxViewContainer.subviews.forEach({ $0.removeFromSuperview() })

        switch mode {
        case .activityIndicator:
            showActivityIndicator()
            
        case .detailsIndicator:
            showDetailsIndicator()
            
        case .none:
            break
        }
    }
    
    private func showActivityIndicator() {
        auxViewContainer.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: auxViewContainer.centerYAnchor),
            activityIndicator.trailingAnchor.constraint(equalTo: auxViewContainer.trailingAnchor, constant: -C.margin)
        ])
        
        activityIndicator.startAnimating()
        
    }
    
    private func showDetailsIndicator() {
        
    }
}

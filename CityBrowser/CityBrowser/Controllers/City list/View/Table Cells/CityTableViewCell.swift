//
//  CityTableViewCell.swift
//  CityBrowser
//
//  Created by Mateusz Popiało on 04/08/2020.
//  Copyright © 2020 Mateusz Popiało. All rights reserved.
//

import UIKit

class CityTableViewCell: UITableViewCell {
    
    private enum C {
        static let inset: CGFloat = 8
        static let margin: CGFloat = 15
        static let imageSide: CGFloat = 44
        static let cornerRadius: CGFloat = 8
        static let imageBackgroundColor = UIColor.lightGray.withAlphaComponent(0.1)
    }
    
    static let identifier = "CityTableViewCellID"
    
    //MARK: - Properties
    private let cityImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = C.cornerRadius
        imageView.backgroundColor = C.imageBackgroundColor
        return imageView
    }()
    
    private let cityNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints  = false
        return label
    }()
    
    private let countryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints  = false
        return label
    }()
    
    private let favoriteIcon: UIImageView = {
        let icon = UIImageView()
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.contentMode = .scaleAspectFit
        icon.image = UIImage(named: "star", in: Bundle(for: CityTableViewCell.self), compatibleWith: nil)
        return icon
    }()
    
    //MARK: - Setup
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        setupCityImageView()
        setupFavIcon()
        setupCountryLabel()
        setupCityNameLabel()
    }
    
    private func setupCityImageView() {
        self.addSubview(cityImageView)
        
        NSLayoutConstraint.activate([
            cityImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            cityImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: C.margin),
            cityImageView.heightAnchor.constraint(equalToConstant: C.imageSide),
            cityImageView.widthAnchor.constraint(equalToConstant: C.imageSide)
        ])
    }
    
    private func setupFavIcon() {
        self.addSubview(favoriteIcon)
        
        NSLayoutConstraint.activate([
            favoriteIcon.centerYAnchor.constraint(equalTo: centerYAnchor),
            favoriteIcon.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -C.margin),
            favoriteIcon.heightAnchor.constraint(equalToConstant: C.imageSide/2),
            favoriteIcon.widthAnchor.constraint(equalToConstant: C.imageSide/2)
        ])
    }
    
    private func setupCountryLabel() {
        self.addSubview(countryLabel)
        
        NSLayoutConstraint.activate([
            countryLabel.topAnchor.constraint(equalTo: topAnchor,constant: C.margin),
            countryLabel.leadingAnchor.constraint(equalTo: cityImageView.trailingAnchor, constant: C.inset),
            countryLabel.trailingAnchor.constraint(equalTo: favoriteIcon.leadingAnchor, constant: C.margin),
            countryLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
    }
    
    private func setupCityNameLabel() {
        self.addSubview(cityNameLabel)
        
        NSLayoutConstraint.activate([
            cityNameLabel.topAnchor.constraint(equalTo: countryLabel.bottomAnchor),
            cityNameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -C.margin),
            cityNameLabel.leadingAnchor.constraint(equalTo: cityImageView.trailingAnchor, constant: C.inset),
            cityNameLabel.trailingAnchor.constraint(equalTo: favoriteIcon.leadingAnchor, constant: C.margin),
            cityNameLabel.heightAnchor.constraint(equalToConstant: 26)
        ])
    }
    
 
    //MARK: - Configuration
    func configure(with viewModel: CityViewModel) {
        cityNameLabel.text = viewModel.captitalCityName
        countryLabel.text = viewModel.country
        if
            let base64 = viewModel.imageBase64String,
            let imageData = Data(base64Encoded: base64, options: .ignoreUnknownCharacters),
            let image = UIImage(data: imageData) {
            cityImageView.image = image
        } else {
            cityImageView.image = nil
        }
        
        favoriteIcon.isHidden = !viewModel.isFavorite
    }
}

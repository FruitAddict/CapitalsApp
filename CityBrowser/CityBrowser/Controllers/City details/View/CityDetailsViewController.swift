//
//  CityDetailsViewController.swift
//  CityBrowser
//
//  Created by Mateusz Popiało on 03/08/2020.
//  Copyright © 2020 Mateusz Popiało. All rights reserved.
//

import UIKit

class CityDetailsViewController: UIViewController {
    
    enum C {
        static let margin: CGFloat = 15
        static let containerViewsCornerRadius: CGFloat = 8
        static let containerViewsColor: UIColor = UIColor.lightGray.withAlphaComponent(0.2)
        static let cornerRadius: CGFloat = 8
        static let imageSide: CGFloat = 80
        static let separatorColor = UIColor.lightGray.withAlphaComponent(0.3)
    }
    
    //MARK: - Properties
    fileprivate let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.bounces = true
        return scrollView
    }()
    
    fileprivate let contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    fileprivate let cityImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = C.cornerRadius
        return imageView
    }()
    
    fileprivate let cityNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 32, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints  = false
        return label
    }()
    
    fileprivate let stackViewContainer: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.layer.cornerRadius = C.containerViewsCornerRadius
        container.backgroundColor = C.containerViewsColor
        return container
    }()
    
    fileprivate let detailsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    fileprivate let countryDescriptionView: CityDetailsDescriptonView = {
        let view = CityDetailsDescriptonView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    fileprivate let numberOfVisitorsView: CityDetailsDescriptonView = {
        let view = CityDetailsDescriptonView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    fileprivate let cityRatingView: CityDetailsDescriptonView = {
        let view = CityDetailsDescriptonView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    fileprivate let favoriteSwitchContainer: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.layer.cornerRadius = C.containerViewsCornerRadius
        container.backgroundColor = C.containerViewsColor
        return container
    }()
    
    fileprivate let favoriteLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Favorite"
        return label
    }()
    
    fileprivate let favoriteSwitch: UISwitch = {
        let favSwitch = UISwitch()
        favSwitch.translatesAutoresizingMaskIntoConstraints = false
        favSwitch.addTarget(self, action: #selector(switchChanged), for: .valueChanged)
        return favSwitch
    }()

    fileprivate(set) var presenter : CityDetailsPresenter?
        
    //MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        presenter?.handleViewIsReady()
    }

    //MARK: - Setup
    private func setupView() {
        self.view.backgroundColor = .white
        
        setupScrollView()
        setupContentView()
        setupCityBasicInfoView()
        setupContainer()
        setupDescriptionViews()
        setupFavoriteSwitch()
    }
    
    private func setupScrollView() {
        self.view.addSubview(scrollView)
        
        let guide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: guide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: guide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func setupContentView() {
        self.scrollView.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    
    private func setupCityBasicInfoView() {
        self.contentView.addSubview(cityImageView)
        self.contentView.addSubview(cityNameLabel)
        NSLayoutConstraint.activate([
            cityImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: C.margin),
            cityImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            cityImageView.heightAnchor.constraint(equalToConstant: C.imageSide),
            cityImageView.widthAnchor.constraint(equalToConstant: C.imageSide),
            cityNameLabel.topAnchor.constraint(equalTo: cityImageView.bottomAnchor, constant: C.margin/2),
            cityNameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }
    
    private func setupContainer() {
        self.contentView.addSubview(stackViewContainer)
        self.stackViewContainer.addSubview(detailsStackView)
        
        NSLayoutConstraint.activate([
            stackViewContainer.topAnchor.constraint(equalTo: cityNameLabel.bottomAnchor, constant: C.margin * 2),
            stackViewContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: C.margin),
            stackViewContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -C.margin),
            detailsStackView.topAnchor.constraint(equalTo: stackViewContainer.topAnchor),
            detailsStackView.bottomAnchor.constraint(equalTo: stackViewContainer.bottomAnchor),
            detailsStackView.leadingAnchor.constraint(equalTo: stackViewContainer.leadingAnchor),
            detailsStackView.trailingAnchor.constraint(equalTo: stackViewContainer.trailingAnchor),
        ])
    }
    
    private func setupDescriptionViews() {
        detailsStackView.addArrangedSubview(countryDescriptionView)
        detailsStackView.addArrangedSubview(makeSeparator())
        
        detailsStackView.addArrangedSubview(numberOfVisitorsView)
        detailsStackView.addArrangedSubview(makeSeparator())
        
        detailsStackView.addArrangedSubview(cityRatingView)
    }
    
    private func makeSeparator() -> UIView {
        let separator = UIView()
        separator.backgroundColor = C.separatorColor
        separator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        return separator
    }
    
    private func setupFavoriteSwitch() {
        self.contentView.addSubview(favoriteSwitchContainer)
        self.favoriteSwitchContainer.addSubview(favoriteLabel)
        self.favoriteSwitchContainer.addSubview(favoriteSwitch)
        
        NSLayoutConstraint.activate([
            favoriteSwitchContainer.topAnchor.constraint(equalTo: stackViewContainer.bottomAnchor, constant: C.margin),
            favoriteSwitchContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: C.margin),
            favoriteSwitchContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -C.margin),
            favoriteSwitchContainer.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor),
            favoriteLabel.leadingAnchor.constraint(equalTo:favoriteSwitchContainer.leadingAnchor, constant: C.margin),
            favoriteLabel.topAnchor.constraint(equalTo:favoriteSwitchContainer.topAnchor, constant: C.margin),
            favoriteLabel.bottomAnchor.constraint(equalTo:favoriteSwitchContainer.bottomAnchor, constant: -C.margin),
            favoriteSwitch.trailingAnchor.constraint(equalTo: favoriteSwitchContainer.trailingAnchor, constant: -C.margin),
            favoriteSwitch.centerYAnchor.constraint(equalTo: favoriteSwitchContainer.centerYAnchor)
        ])
    }

    //MARK: - Attaching presenter
    func setPresenter(_ presenter: CityDetailsPresenter) {
        self.presenter = presenter
        presenter.attach(view: self)
    }
    
    //MARK: - Actions
    @objc func switchChanged() {
        presenter?.handleFavoriteFlagChanged(favoriteSwitch.isOn)
    }
}


//MARK: - CityDetailsView conformance
extension CityDetailsViewController: CityDetailsView {
    
    func setTitle(_ title: String) {
        navigationItem.title = title
    }

    func setViewModel(_ viewModel: CityDetailsViewModel) {
        if
              let base64 = viewModel.imageBase64,
              let imageData = Data(base64Encoded: base64, options: .ignoreUnknownCharacters),
              let image = UIImage(data: imageData) {
              cityImageView.image = image
          } else {
              cityImageView.image = nil
        }
        cityNameLabel.text = viewModel.cityName
   
        countryDescriptionView.configure(withTitle: viewModel.country, description: "Country", mode: .none)
        
        configureNumberOfVisitors(with: viewModel)
        
        configureCityRating(with: viewModel)
        
        favoriteSwitch.isOn = viewModel.isFavorite
    }
    
    private func configureNumberOfVisitors(with viewModel: CityDetailsViewModel) {
        let numberOfVisitorsViewMode: CityDetailsDescriptonView.AuxViewMode
        var numerOfVisitorsString: String = ""
        
        switch viewModel.numberOfVisitors {
        case .initial:
            numberOfVisitorsViewMode = .none

        case .loading:
            numberOfVisitorsViewMode = .activityIndicator
            numerOfVisitorsString = "Loading..."

        case .loaded(let value):
            numberOfVisitorsViewMode = .detailsIndicator
            numerOfVisitorsString = value

        case .error:
            numberOfVisitorsViewMode = .none
            numerOfVisitorsString = "Please try again later"
        }
        
        numberOfVisitorsView.configure(withTitle: numerOfVisitorsString, description: "Recent visitors", mode: numberOfVisitorsViewMode)
    }
    
    private func configureCityRating(with viewModel: CityDetailsViewModel) {
        let numberOfVisitorsViewMode: CityDetailsDescriptonView.AuxViewMode
        var ratingString: String = ""
        
        switch viewModel.rating {
        case .initial:
            numberOfVisitorsViewMode = .none

        case .loading:
            numberOfVisitorsViewMode = .activityIndicator
            ratingString = "Loading..."

        case .loaded(let value):
            numberOfVisitorsViewMode = .none
            ratingString = value

        case .error:
            numberOfVisitorsViewMode = .none
            ratingString = "Please try again later"
        }
        
        cityRatingView.configure(withTitle: ratingString, description: "City rating", mode: numberOfVisitorsViewMode)
    }
}

//
//  ErrorViewController.swift
//  CityBrowser
//
//  Created by Mateusz Popiało on 05/08/2020.
//  Copyright © 2020 Mateusz Popiało. All rights reserved.
//

import UIKit

class ErrorViewController: UIViewController {
    
    enum C {
        static let labelCenterOffset: CGFloat = 20
        static let margin: CGFloat = 15
        static let cornerRadius: CGFloat = 4
    }

    //MARK: - Properties
    fileprivate let errorTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    fileprivate let errorMessageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    fileprivate let retryButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.blue.cgColor
        button.layer.cornerRadius = C.cornerRadius
        button.setTitle("Retry", for: .normal)
        button.setTitleColor(UIColor.blue, for: .normal)
        return button
    }()
    
    fileprivate(set) var presenter : ErrorPresenter?
        
    //MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        presenter?.handleViewIsReady()
    }
    
    //MARK: - Setup
    private func setupView() {
        self.view.backgroundColor = .white
        
        setupLabels()
        setupRetryButton()
    }
    
    private func setupLabels() {
        
        self.view.addSubview(errorTitleLabel)
        self.view.addSubview(errorMessageLabel)
        
        NSLayoutConstraint.activate([
            errorTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            errorTitleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -C.labelCenterOffset),
            errorMessageLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            errorMessageLabel.topAnchor.constraint(equalTo: errorTitleLabel.bottomAnchor),
            errorMessageLabel.widthAnchor.constraint(equalToConstant: view.frame.width*2/3)
        ])
    }
    
    private func setupRetryButton() {
        self.view.addSubview(retryButton)
        NSLayoutConstraint.activate([
            retryButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            retryButton.topAnchor.constraint(equalTo: errorMessageLabel.bottomAnchor, constant: C.margin * 2),
            retryButton.widthAnchor.constraint(equalToConstant: view.frame.width/2),
            retryButton.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        retryButton.addTarget(self, action: #selector(retryButtonPressed), for: .touchUpInside)
    }
    
    
    //MARK: - Attaching presenter
    func setPresenter(_ presenter: ErrorPresenter) {
        self.presenter = presenter
        presenter.attach(view: self)
    }
    
    //MARK: - Actions
    @objc func retryButtonPressed() {
        presenter?.handleRetryButtonPressed()
    }
}

//MARK: - ErrorView conformance
extension ErrorViewController: ErrorView {
    
    func setData(title: String, message: String) {
        errorTitleLabel.text = title
        errorMessageLabel.text = message
    }
    
    func dismiss(completion: @escaping () -> Void) {
        self.dismiss(animated: true, completion: completion)
    }

}

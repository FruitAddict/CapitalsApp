//
//  CityListViewController.swift
//  CityBrowser
//
//  Created by Mateusz Popiało on 03/08/2020.
//  Copyright © 2020 Mateusz Popiało. All rights reserved.
//

import UIKit

class CityListViewController: UIViewController {
    
    //MARK: - Properties
    fileprivate let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 50
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    fileprivate let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    fileprivate lazy var filterButton:  UIBarButtonItem = {
        return .init(title: "", style: .plain, target: self, action: #selector(onFilterButtonPressed))
    }()
    
    fileprivate(set) var presenter : CityListPresenter?
    
    fileprivate var cityViewModels: [CityViewModel] = []
    
    //MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupView()
        registerTableViewCells()
        
        presenter?.handleViewIsReady()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: selectedIndexPath, animated: true)
        }
        
        presenter?.handleViewDidAppear()
    }
     
    //MARK: - Setup
    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = filterButton
    }
    
    private func setupView() {
        self.view.backgroundColor = .white
        
        setupTableView()
        setupIndicatorView()
    }
    
    private func setupTableView() {
        self.view.addSubview(tableView)
        
        let guide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: guide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: guide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setupIndicatorView() {
        self.view.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func registerTableViewCells() {
        tableView.register(CityTableViewCell.self, forCellReuseIdentifier: CityTableViewCell.identifier)
    }
     
    //MARK: - Attaching presenter
    func setPresenter(_ presenter: CityListPresenter) {
        self.presenter = presenter
        presenter.attach(view: self)
    }
    
    //MARK: - Actions
    @objc func onFilterButtonPressed() {
        presenter?.handleFilterButtonPressed()
    }
}


//MARK: - CityListView conformance
extension CityListViewController: CityListView {
    
    func setActivityIndicatorVisibility(_ visible: Bool) {
        DispatchQueue.main.async {
            self.activityIndicator.isHidden = !visible
            self.tableView.isHidden = visible
            
            if visible {
                self.activityIndicator.startAnimating()
            } else {
                self.activityIndicator.stopAnimating()
            }
        }
    }
    
    func setCityViewModels(_ models: [CityViewModel]) {
        DispatchQueue.main.async {
            self.cityViewModels = models
            self.tableView.reloadData()
        }
    }
    
    func updateCityViewModels(newModels models: [CityViewModel], reloadingAtIndex index: Int) {
        DispatchQueue.main.async {
            self.cityViewModels = models            
            guard
                let visiblePaths = self.tableView.indexPathsForVisibleRows,
                !visiblePaths.isEmpty
            else {
                return
            }
            
            guard
                let path = visiblePaths.first(where: { $0.row == index })
            else {
                return
            }
            
            self.updateCell(atIndexPath: path)
        }
    }
    
    func updateCityViewModels(newModels models: [CityViewModel]) {
        DispatchQueue.main.async {
            self.cityViewModels = models
            self.tableView.indexPathsForVisibleRows?.forEach(self.updateCell)
        }
    }
    
    private func updateCell(atIndexPath indexPath: IndexPath) {
        guard
            let cell = self.tableView.cellForRow(at: indexPath) as? CityTableViewCell
        else {
            return
        }
        let viewModel = cityViewModels[indexPath.row]
        cell.configure(with: viewModel)

    }
    
    func setTitle(_ title: String) {
        DispatchQueue.main.async {
            self.navigationItem.title = title
        }
    }
    
    func setFilteringEnabled(_ filteringEnabled: Bool) {
        filterButton.title = filteringEnabled ? "Show all" : "Show fav."
    }

}

//MARK: - TableView Delegate & DataSource
extension CityListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: CityTableViewCell.identifier, for: indexPath) as? CityTableViewCell
        else {
            fatalError("Table view cell with id \(CityTableViewCell.identifier) is not registered.")
        }
        
        let viewModel = self.cityViewModels[indexPath.row]
        
        cell.configure(with: viewModel)
        
        presenter?.handleCityIsAboutToBeDisplayed(atIndex: indexPath.row)
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.handleCitySelected(atIndex: indexPath.row)
    }
}

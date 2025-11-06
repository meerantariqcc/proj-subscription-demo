//
//  ServiceListViewController.swift
//  SubscriptionDemo
//
//  Created by Meeran Tariq on 07/11/2025.
//

import UIKit

/// A delegate protocol for communicating service selections from `ServiceListViewController`.
protocol ServiceListViewControllerDelegate: AnyObject {
    /// Notifies the delegate that a service was selected.
    /// - Parameters:
    ///   - controller: The `ServiceListViewController` that made the selection.
    ///   - service: The `Service` that was selected.
    func serviceListViewController(_ controller: ServiceListViewController, didSelect service: Service)
}

/// A view controller that displays a list of services with search functionality.
class ServiceListViewController: UIViewController {

    weak var delegate: ServiceListViewControllerDelegate?

    private let searchBar = UISearchBar()
    private let tableView = UITableView()

    private var services: [Service] = [
        Service(name: "Netflix", imageName: "netflix_icon", amount: 15.99),
        Service(name: "Hulu", imageName: "hulu_icon", amount: 12.99),
        Service(name: "Spotify", imageName: "spotify_icon", amount: 9.99),
        Service(name: "PlayStation+", imageName: "playstation_icon", amount: 9.99),
        Service(name: "Paramount+", imageName: "paramount_icon", amount: 5.99),
        Service(name: "YouTube Music", imageName: "youtube_music_icon", amount: 9.99)
    ]
    private var filteredServices: [Service] = []

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupNavigationBar()
        setupSearchBar()
        setupTableView()
        filteredServices = services
    }

    // MARK: - UI Setup

    /// Sets up the navigation bar with a title and a "Done" button.
    private func setupNavigationBar() {
        navigationItem.title = "Services"
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonTapped))
        navigationItem.rightBarButtonItem = doneButton
    }

    /// Sets up the search bar and adds it to the view hierarchy.
    private func setupSearchBar() {
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = "Search"
        searchBar.delegate = self
        view.addSubview(searchBar)

        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    /// Sets up the table view and adds it to the view hierarchy.
    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ServiceCell.self, forCellReuseIdentifier: "ServiceCell")
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    // MARK: - Actions

    /// Handles the tap event on the "Done" button in the navigation bar.
    @objc private func doneButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension ServiceListViewController: UITableViewDelegate, UITableViewDataSource {
    /// Returns the number of rows in a given section of the table view.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredServices.count
    }

    /// Configures and returns a cell for a given row and section.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ServiceCell", for: indexPath) as! ServiceCell
        let service = filteredServices[indexPath.row]
        cell.configure(with: service)
        return cell
    }

    /// Handles the selection of a service in the table view.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedService = filteredServices[indexPath.row]
        delegate?.serviceListViewController(self, didSelect: selectedService)
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - UISearchBarDelegate

extension ServiceListViewController: UISearchBarDelegate {
    /// Tells the delegate that the text in the search bar has changed.
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredServices = searchText.isEmpty ? services : services.filter {
            $0.name.lowercased().contains(searchText.lowercased())
        }
        tableView.reloadData()
    }

    /// Tells the delegate that the search button was tapped.
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

/// A custom table view cell for displaying service information.
class ServiceCell: UITableViewCell {

    let serviceImageView = UIImageView()
    let serviceNameLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// Sets up the subviews of the cell and their constraints.
    private func setupViews() {
        serviceImageView.translatesAutoresizingMaskIntoConstraints = false
        serviceImageView.contentMode = .scaleAspectFit
        serviceImageView.clipsToBounds = true
        serviceImageView.layer.cornerRadius = 15 // Half of desired size for circular image
        contentView.addSubview(serviceImageView)

        serviceNameLabel.translatesAutoresizingMaskIntoConstraints = false
        serviceNameLabel.font = .preferredFont(forTextStyle: .body)
        contentView.addSubview(serviceNameLabel)

        NSLayoutConstraint.activate([
            serviceImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            serviceImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            serviceImageView.widthAnchor.constraint(equalToConstant: 30),
            serviceImageView.heightAnchor.constraint(equalToConstant: 30),

            serviceNameLabel.leadingAnchor.constraint(equalTo: serviceImageView.trailingAnchor, constant: 15),
            serviceNameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }

    /// Configures the cell with a given service.
    /// - Parameter service: The `Service` object to display.
    func configure(with service: Service) {
        serviceNameLabel.text = service.name
        serviceImageView.image = UIImage(named: service.imageName) // Assuming image names match asset catalog
    }
}

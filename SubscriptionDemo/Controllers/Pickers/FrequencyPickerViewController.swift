//
//  FrequencyPickerViewController.swift
//  SubscriptionDemo
//
//  Created by Meeran Tariq on 07/11/2025.
//

import UIKit

/// A delegate protocol for communicating selected frequencies from `FrequencyPickerViewController`.
protocol FrequencyPickerViewControllerDelegate: AnyObject {
    /// Notifies the delegate that a frequency was selected.
    /// - Parameters:
    ///   - controller: The `FrequencyPickerViewController` that made the selection.
    ///   - frequency: The selected frequency string.
    func frequencyPickerViewController(_ controller: FrequencyPickerViewController, didSelect frequency: String)
}

/// A view controller that presents a list of frequency options for selection.
class FrequencyPickerViewController: UIViewController {

    weak var delegate: FrequencyPickerViewControllerDelegate?
    /// The currently selected frequency, used to pre-select an option in the picker.
    var selectedFrequency: String? 

    private let frequencies = ["Weekly", "Monthly", "Annually"]
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupNavigationBar()
        setupTableView()
    }

    // MARK: - UI Setup

    /// Sets up the navigation bar with a title and a "Done" button.
    private func setupNavigationBar() {
        navigationItem.title = "Frequency"
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonTapped))
        navigationItem.rightBarButtonItem = doneButton
    }

    /// Sets up the table view to display frequency options.
    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isScrollEnabled = false
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    // MARK: - Actions

    /// Handles the tap event on the "Done" button in the navigation bar, notifying the delegate with the selected frequency.
    @objc private func doneButtonTapped() {
        if let selectedFrequency = selectedFrequency {
            delegate?.frequencyPickerViewController(self, didSelect: selectedFrequency)
        }
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension FrequencyPickerViewController: UITableViewDelegate, UITableViewDataSource {
    /// Returns the number of rows in the table view, which corresponds to the number of frequency options.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return frequencies.count
    }

    /// Configures and returns a table view cell for a given row.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "FrequencyCell")
        let frequency = frequencies[indexPath.row]
        cell.textLabel?.text = frequency
        if frequency == selectedFrequency {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
    }

    /// Handles the selection of a frequency option in the table view.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selectedFrequency = frequencies[indexPath.row]
        tableView.reloadData()
    }
}

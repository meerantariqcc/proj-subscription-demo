//
//  DatePickerViewController.swift
//  SubscriptionDemo
//
//  Created by Meeran Tariq on 07/11/2025.
//

import UIKit

/// A delegate protocol for communicating selected dates from `DatePickerViewController`.
protocol DatePickerViewControllerDelegate: AnyObject {
    /// Notifies the delegate that a date was selected.
    /// - Parameters:
    ///   - controller: The `DatePickerViewController` that made the selection.
    ///   - date: The `Date` that was selected.
    func datePickerViewController(_ controller: DatePickerViewController, didSelect date: Date)
}

/// A view controller that presents a `UIDatePicker` in a bottom sheet.
class DatePickerViewController: UIViewController {

    weak var delegate: DatePickerViewControllerDelegate?
    private let datePicker = UIDatePicker()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupNavigationBar()
        setupDatePicker()
    }

    // MARK: - UI Setup

    /// Sets up the navigation bar with a title and a "Done" button.
    private func setupNavigationBar() {
        navigationItem.title = "Start Date"
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonTapped))
        navigationItem.rightBarButtonItem = doneButton
    }

    /// Sets up the `UIDatePicker` and adds it to the view hierarchy.
    private func setupDatePicker() {
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.datePickerMode = .date
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }
        view.addSubview(datePicker)

        NSLayoutConstraint.activate([
            datePicker.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            datePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            datePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            datePicker.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    // MARK: - Actions

    /// Handles the tap event on the "Done" button in the navigation bar, notifying the delegate with the selected date.
    @objc private func doneButtonTapped() {
        delegate?.datePickerViewController(self, didSelect: datePicker.date)
        dismiss(animated: true, completion: nil)
    }
}

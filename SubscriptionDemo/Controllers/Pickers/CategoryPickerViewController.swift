//
//  CategoryPickerViewController.swift
//  SubscriptionDemo
//
//  Created by Meeran Tariq on 07/11/2025.
//

import UIKit

/// A delegate protocol for communicating selected categories from `CategoryPickerViewController`.
protocol CategoryPickerViewControllerDelegate: AnyObject {
    /// Notifies the delegate that a category was selected.
    /// - Parameters:
    ///   - controller: The `CategoryPickerViewController` that made the selection.
    ///   - category: The `Category` that was selected.
    func categoryPickerViewController(_ controller: CategoryPickerViewController, didSelect category: Category)
}

/// A struct representing a subscription category.
struct Category {
    let name: String
    let imageName: String
}

/// A view controller that presents a list of category options for selection.
class CategoryPickerViewController: UIViewController {

    weak var delegate: CategoryPickerViewControllerDelegate?
    /// The currently selected category, used to pre-select an option in the picker.
    var selectedCategory: Category?

    private let categories = [
        Category(name: "Subscription", imageName: "arrow.clockwise.circle.fill"),
        Category(name: "Utility", imageName: "wrench.and.screwdriver.fill"),
        Category(name: "Card Payment", imageName: "creditcard.fill"),
        Category(name: "Loan", imageName: "dollarsign.circle.fill"),
        Category(name: "Rent", imageName: "house.fill")
    ]
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
        navigationItem.title = "Category"
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonTapped))
        navigationItem.rightBarButtonItem = doneButton
    }

    /// Sets up the table view to display category options.
    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isScrollEnabled = false
        tableView.register(CategoryCell.self, forCellReuseIdentifier: "CategoryCell")
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    // MARK: - Actions

    /// Handles the tap event on the "Done" button in the navigation bar, notifying the delegate with the selected category.
    @objc private func doneButtonTapped() {
        if let selectedCategory = selectedCategory {
            delegate?.categoryPickerViewController(self, didSelect: selectedCategory)
        }
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension CategoryPickerViewController: UITableViewDelegate, UITableViewDataSource {
    /// Returns the number of rows in the table view, which corresponds to the number of category options.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }

    /// Configures and returns a table view cell for a given row.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
        let category = categories[indexPath.row]
        cell.configure(with: category)
        if category.name == selectedCategory?.name {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
    }

    /// Handles the selection of a category option in the table view.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selectedCategory = categories[indexPath.row]
        tableView.reloadData()
    }
}

/// A custom table view cell for displaying category information.
class CategoryCell: UITableViewCell {

    let categoryImageView = UIImageView()
    let categoryNameLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// Sets up the subviews of the cell and their constraints.
    private func setupViews() {
        categoryImageView.translatesAutoresizingMaskIntoConstraints = false
        categoryImageView.contentMode = .scaleAspectFit
        categoryImageView.clipsToBounds = true
        categoryImageView.tintColor = .systemGray
        contentView.addSubview(categoryImageView)

        categoryNameLabel.translatesAutoresizingMaskIntoConstraints = false
        categoryNameLabel.font = .preferredFont(forTextStyle: .body)
        contentView.addSubview(categoryNameLabel)

        NSLayoutConstraint.activate([
            categoryImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            categoryImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            categoryImageView.widthAnchor.constraint(equalToConstant: 25),
            categoryImageView.heightAnchor.constraint(equalToConstant: 25),

            categoryNameLabel.leadingAnchor.constraint(equalTo: categoryImageView.trailingAnchor, constant: 15),
            categoryNameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }

    /// Configures the cell with a given category.
    /// - Parameter category: The `Category` object to display.
    func configure(with category: Category) {
        categoryNameLabel.text = category.name
        categoryImageView.image = UIImage(systemName: category.imageName)
    }
}

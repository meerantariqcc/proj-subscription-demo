import UIKit

class CreateSubscriptionViewController: UIViewController {

    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    private var selectedService: Service? // New property to store the selected service
    private let plusCircleButton = UIButton(type: .system)
    private let titleLabel = UILabel()
    private let amountLabel = UILabel()
    private let serviceLogoImageView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGroupedBackground
        setupNavigationBar()
        setupChooseServiceSection()
        setupTableView()
    }

    // MARK: - UI Setup

    /// Sets up the navigation bar with a close button on the left and a save button on the right.
    private func setupNavigationBar() {
        navigationItem.title = "Create Subscription"
        
        // Close button
        let closeButton = UIBarButtonItem(image: UIImage(systemName: "xmark.circle.fill"), style: .plain, target: self, action: #selector(closeButtonTapped))
        closeButton.tintColor = .systemGray
        navigationItem.leftBarButtonItem = closeButton
        
        // Save button
        let saveButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveButtonTapped))
        navigationItem.rightBarButtonItem = saveButton
    }

    /// Sets up the "Choose a service" section, which includes a plus icon, text labels, and a tap gesture recognizer.
    private func setupChooseServiceSection() {
        let chooseServiceView = UIView()
        chooseServiceView.translatesAutoresizingMaskIntoConstraints = false
        chooseServiceView.backgroundColor = .secondarySystemGroupedBackground
        chooseServiceView.layer.cornerRadius = 10
        view.addSubview(chooseServiceView)

        plusCircleButton.translatesAutoresizingMaskIntoConstraints = false
        plusCircleButton.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        plusCircleButton.tintColor = UIColor(named: "AccentColor")
        plusCircleButton.contentVerticalAlignment = .fill
        plusCircleButton.contentHorizontalAlignment = .fill
        plusCircleButton.imageView?.contentMode = .scaleAspectFit
        plusCircleButton.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
        plusCircleButton.isUserInteractionEnabled = false
        chooseServiceView.addSubview(plusCircleButton)

        serviceLogoImageView.translatesAutoresizingMaskIntoConstraints = false
        serviceLogoImageView.contentMode = .scaleAspectFit
        serviceLogoImageView.isHidden = true // Initially hidden
        chooseServiceView.addSubview(serviceLogoImageView)

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "Choose a service"
        titleLabel.font = .preferredFont(forTextStyle: .body)
        titleLabel.textColor = .systemGray
        titleLabel.tag = 101 // Tag for service name
        chooseServiceView.addSubview(titleLabel)

        amountLabel.translatesAutoresizingMaskIntoConstraints = false
        amountLabel.text = "$0"
        amountLabel.font = .preferredFont(forTextStyle: .subheadline)
        amountLabel.textColor = .gray
        amountLabel.tag = 102 // Tag for service amount
        chooseServiceView.addSubview(amountLabel)

        NSLayoutConstraint.activate([
            chooseServiceView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            chooseServiceView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            chooseServiceView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            chooseServiceView.heightAnchor.constraint(equalToConstant: 80),

            plusCircleButton.leadingAnchor.constraint(equalTo: chooseServiceView.leadingAnchor, constant: 15),
            plusCircleButton.centerYAnchor.constraint(equalTo: chooseServiceView.centerYAnchor),
            plusCircleButton.widthAnchor.constraint(equalToConstant: 40),
            plusCircleButton.heightAnchor.constraint(equalToConstant: 40),

            serviceLogoImageView.leadingAnchor.constraint(equalTo: chooseServiceView.leadingAnchor, constant: 15),
            serviceLogoImageView.centerYAnchor.constraint(equalTo: chooseServiceView.centerYAnchor),
            serviceLogoImageView.widthAnchor.constraint(equalToConstant: 40),
            serviceLogoImageView.heightAnchor.constraint(equalToConstant: 40),

            titleLabel.leadingAnchor.constraint(equalTo: plusCircleButton.trailingAnchor, constant: 15),
            titleLabel.bottomAnchor.constraint(equalTo: chooseServiceView.centerYAnchor, constant: 0),

            amountLabel.leadingAnchor.constraint(equalTo: plusCircleButton.trailingAnchor, constant: 15),
            amountLabel.topAnchor.constraint(equalTo: chooseServiceView.centerYAnchor, constant: 0),
        ])
    }

    /// Sets up the table view for input fields and other subscription details.
    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isScrollEnabled = false
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    // MARK: - Actions

    /// Handles the tap event on the close button in the navigation bar.
    @objc private func closeButtonTapped() {
        dismiss(animated: true, completion: nil)
    }

    /// Handles the tap event on the save button in the navigation bar.
    @objc private func saveButtonTapped() {
        // Handle save action
    }

    /// Handles the tap event on the plus circle button in the "Choose a service" section.
    @objc private func plusButtonTapped() {
        // Handle plus button tap
        print("Plus button tapped")
    }

    /// Handles the tap event on the "Choose a service" view.
    @objc private func chooseServiceViewTapped() {
        let serviceListVC = ServiceListViewController()
        serviceListVC.delegate = self
        serviceListVC.selectedService = selectedService // Pass the currently selected service
        let navigationController = UINavigationController(rootViewController: serviceListVC)
        if let sheet = navigationController.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            sheet.prefersEdgeAttachedInCompactHeight = true
            sheet.widthFollowsPreferredContentSizeWhenEdgeAttached = true
        }
        present(navigationController, animated: true, completion: nil)
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension CreateSubscriptionViewController: UITableViewDelegate, UITableViewDataSource {
    /// Returns the number of sections in the table view.
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2 // One section for Name, Amount, Category, another for Date, Frequency, Active
    }

    /// Returns the number of rows in a given section of the table view.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 3 // Name, Amount, Category
        } else {
            return 3 // Start Date, Frequency, Active
        }
    }

    /// Configures and returns a cell for a given row and section.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "cell")
        cell.selectionStyle = .none

        if indexPath.section == 0 {
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = "Name"
                cell.detailTextLabel?.text = selectedService?.name ?? "Choose a service"
                cell.accessoryType = .disclosureIndicator
            case 1:
                cell.textLabel?.text = "Amount"
                let textField = UITextField()
                textField.placeholder = "$0"
                textField.textAlignment = .right
                textField.keyboardType = .decimalPad
                textField.translatesAutoresizingMaskIntoConstraints = false
                textField.isUserInteractionEnabled = false // Make the text field uneditable
                if let amount = selectedService?.amount {
                    textField.text = String(format: "%.2f", amount) // Set the amount from selectedService
                }
                cell.contentView.addSubview(textField)
                NSLayoutConstraint.activate([
                    textField.leadingAnchor.constraint(equalTo: cell.textLabel!.trailingAnchor, constant: 10),
                    textField.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: -20),
                    textField.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor)
                ])
            case 2:
                cell.textLabel?.text = "Category"
                cell.detailTextLabel?.text = "Subscription"
                cell.accessoryType = .disclosureIndicator
            default:
                break
            }
        } else if indexPath.section == 1 {
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = "Start Date"
                cell.detailTextLabel?.text = "Apr 12, 2025"
                cell.accessoryType = .disclosureIndicator
            case 1:
                cell.textLabel?.text = "Frequency"
                cell.detailTextLabel?.text = "Weekly"
                cell.accessoryType = .disclosureIndicator
            case 2:
                cell.textLabel?.text = "Active"
                let activeSwitch = UISwitch()
                activeSwitch.translatesAutoresizingMaskIntoConstraints = false
                activeSwitch.isOn = true
                activeSwitch.onTintColor = UIColor(named: "AccentColor")
                cell.contentView.addSubview(activeSwitch)
                NSLayoutConstraint.activate([
                    activeSwitch.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: -20),
                    activeSwitch.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor)
                ])
            default:
                break
            }
        }

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        if indexPath.section == 0 && indexPath.row == 0 { // Name cell
            let serviceListVC = ServiceListViewController()
            serviceListVC.delegate = self
            serviceListVC.selectedService = selectedService // Pass the currently selected service
            let navigationController = UINavigationController(rootViewController: serviceListVC)
            if let sheet = navigationController.sheetPresentationController {
                sheet.detents = [.medium(), .large()]
                sheet.prefersScrollingExpandsWhenScrolledToEdge = false
                sheet.prefersEdgeAttachedInCompactHeight = true
                sheet.widthFollowsPreferredContentSizeWhenEdgeAttached = true
            }
            present(navigationController, animated: true, completion: nil)
        } else if indexPath.section == 1 && indexPath.row == 0 { // Start Date cell
            let datePickerVC = DatePickerViewController()
            datePickerVC.delegate = self
            let navigationController = UINavigationController(rootViewController: datePickerVC)
            if let sheet = navigationController.sheetPresentationController {
                sheet.detents = [.medium(), .large()]
                sheet.prefersScrollingExpandsWhenScrolledToEdge = false
                sheet.prefersEdgeAttachedInCompactHeight = true
                sheet.widthFollowsPreferredContentSizeWhenEdgeAttached = true
            }
            present(navigationController, animated: true, completion: nil)
        } else if indexPath.section == 1 && indexPath.row == 1 { // Frequency cell
            let frequencyPickerVC = FrequencyPickerViewController()
            frequencyPickerVC.delegate = self
            // Pass the current selected frequency to pre-select it in the picker
            if let cell = tableView.cellForRow(at: indexPath), let currentFrequency = cell.detailTextLabel?.text {
                frequencyPickerVC.selectedFrequency = currentFrequency
            }
            let navigationController = UINavigationController(rootViewController: frequencyPickerVC)
            if let sheet = navigationController.sheetPresentationController {
                sheet.detents = [.medium(), .large()]
                sheet.prefersScrollingExpandsWhenScrolledToEdge = false
                sheet.prefersEdgeAttachedInCompactHeight = true
                sheet.widthFollowsPreferredContentSizeWhenEdgeAttached = true
            }
            present(navigationController, animated: true, completion: nil)
        } else if indexPath.section == 0 && indexPath.row == 2 { // Category cell
            let categoryPickerVC = CategoryPickerViewController()
            categoryPickerVC.delegate = self
            // Pass the current selected category to pre-select it in the picker
            if let cell = tableView.cellForRow(at: indexPath), let currentCategoryName = cell.detailTextLabel?.text {
                categoryPickerVC.selectedCategory = Category(name: currentCategoryName, imageName: "") // Image name is not critical for pre-selection
            }
            let navigationController = UINavigationController(rootViewController: categoryPickerVC)
            if let sheet = navigationController.sheetPresentationController {
                sheet.detents = [.medium(), .large()]
                sheet.prefersScrollingExpandsWhenScrolledToEdge = false
                sheet.prefersEdgeAttachedInCompactHeight = true
                sheet.widthFollowsPreferredContentSizeWhenEdgeAttached = true
            }
            present(navigationController, animated: true, completion: nil)
        }
    }
}

extension CreateSubscriptionViewController: ServiceListViewControllerDelegate {
    func serviceListViewController(_ controller: ServiceListViewController, didSelect service: Service) {
        // Update UI with selected service
        print("Selected service: \(service.name)")
        // You would typically update labels or other UI elements here
        titleLabel.text = service.name
        titleLabel.textColor = .black
        serviceLogoImageView.image = UIImage(named: service.imageName) // Set the image for the image view
        serviceLogoImageView.isHidden = false // Show the image view
        plusCircleButton.isHidden = true // Hide the plus button
        if let serviceAmountLabel = (view.viewWithTag(102) as? UILabel) { // Assuming tag 102 for service amount
            serviceAmountLabel.text = "$\(String(format: "%.2f", service.amount))"
        }
        self.selectedService = service // Store the selected service
        tableView.reloadRows(at: [IndexPath(row: 0, section: 0), IndexPath(row: 1, section: 0)], with: .automatic) // Reload Name and Amount rows
    }
}

extension CreateSubscriptionViewController: DatePickerViewControllerDelegate {
    func datePickerViewController(_ controller: DatePickerViewController, didSelect date: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        // Find the cell and update its detailTextLabel
        let indexPath = IndexPath(row: 0, section: 1) // Start Date is at section 1, row 0
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.detailTextLabel?.text = dateFormatter.string(from: date)
        }
    }
}

extension CreateSubscriptionViewController: FrequencyPickerViewControllerDelegate {
    func frequencyPickerViewController(_ controller: FrequencyPickerViewController, didSelect frequency: String) {
        let indexPath = IndexPath(row: 1, section: 1) // Frequency is at section 1, row 1
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.detailTextLabel?.text = frequency
        }
    }
}

extension CreateSubscriptionViewController: CategoryPickerViewControllerDelegate {
    func categoryPickerViewController(_ controller: CategoryPickerViewController, didSelect category: Category) {
        let indexPath = IndexPath(row: 2, section: 0) // Category is at section 0, row 2
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.detailTextLabel?.text = category.name
        }
    }
}


/*
 Plan
 
 - Additional functionalities
 - Docs
 - App Icon
 - Splash
 */


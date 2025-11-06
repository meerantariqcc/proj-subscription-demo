import UIKit

class SubscriptionListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Subscriptions"
        setupNavigationBar()
        setupTableView()
    }

    let tableView = UITableView()
    var subscriptions: [Subscription] = []

    func setupNavigationBar() {
        let plusButton = UIBarButtonItem(image: UIImage(systemName: "plus.circle.fill"), style: .plain, target: self, action: #selector(plusButtonTapped))
        navigationItem.rightBarButtonItem = plusButton
    }

    @objc func plusButtonTapped() {
        let createSubscriptionVC = CreateSubscriptionViewController()
        createSubscriptionVC.delegate = self
        let navigationController = UINavigationController(rootViewController: createSubscriptionVC)
        present(navigationController, animated: true, completion: nil)
    }

    func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "SubscriptionCell")
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension SubscriptionListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subscriptions.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SubscriptionCell", for: indexPath)
        let subscription = subscriptions[indexPath.row]
        cell.textLabel?.text = subscription.serviceName
        cell.detailTextLabel?.text = String(format: "$%.2f", subscription.amount)
        return cell
    }
}

extension SubscriptionListViewController: CreateSubscriptionViewControllerDelegate {
    func createSubscriptionViewController(_ controller: CreateSubscriptionViewController, didSaveSubscription subscription: Subscription) {
        subscriptions.append(subscription)
        tableView.reloadData()
    }
}

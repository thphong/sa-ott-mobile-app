//
//  AddContactViewController.swift
//  bkalo
//
//  Created by Nguyen Minh Tam on 15/4/25.
//

import UIKit

final class AddContactViewController: UIViewController {
    
    // MARK: - UI Components
    private lazy var searchBar: UISearchBar = {
        let bar = UISearchBar()
        bar.placeholder = "Search by username or phone"
        bar.delegate = self
        bar.searchBarStyle = .minimal
        bar.autocapitalizationType = .none
        bar.translatesAutoresizingMaskIntoConstraints = false
        return bar
    }()
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.register(ContactSearchCell.self, forCellReuseIdentifier: String(describing: ContactSearchCell.self))
        table.delegate = self
        table.dataSource = self
        table.keyboardDismissMode = .onDrag
        table.tableFooterView = UIView()
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    private lazy var emptyStateView: EmptyStateView = {
        let view = EmptyStateView()
        view.configure(
            image: UIImage(systemName: "magnifyingglass"),
            title: "No Results Found",
            subtitle: "Try searching with a different username or phone number"
        )
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Properties
    private var searchResults: [ChatPartner] = []
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNavigation()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(searchBar)
        view.addSubview(tableView)
        view.addSubview(emptyStateView)
        
        NSLayoutConstraint.activate([
            // SearchBar constraints
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            // TableView constraints
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            // EmptyState constraints
            emptyStateView.centerXAnchor.constraint(equalTo: tableView.centerXAnchor),
            emptyStateView.centerYAnchor.constraint(equalTo: tableView.centerYAnchor),
            emptyStateView.leadingAnchor.constraint(greaterThanOrEqualTo: tableView.leadingAnchor, constant: 20),
            emptyStateView.trailingAnchor.constraint(lessThanOrEqualTo: tableView.trailingAnchor, constant: -20)
        ])
    }
    
    private func setupNavigation() {
        title = "Add Contact"
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .cancel,
            target: self,
            action: #selector(dismissAction)
        )
    }
    
    private func updateEmptyState() {
        emptyStateView.isHidden = !searchResults.isEmpty
        tableView.isHidden = searchResults.isEmpty
    }
    
    // MARK: - Actions
    @objc private func dismissAction() {
        dismiss(animated: true)
    }
    
    private func performSearch(query: String) {
        guard !query.isEmpty else {
            searchResults = []
            tableView.reloadData()
            updateEmptyState()
            return
        }
        
        // Show loading indicator
        emptyStateView.showLoading()
        
        ContactService.shared.searchContacts(query: query) { success, results in
            DispatchQueue.main.async {
                if success {
                    self.searchResults = results ?? []
                } else {
                    self.searchResults = []
                }
                
                self.tableView.reloadData()
                self.updateEmptyState()
            }
        }
    }
    
    private func sendContactRequest(to user: ChatPartner) {
//        ContactService.shared.sendContactRequest(to: user.id) { [weak self] result in
//            DispatchQueue.main.async {
//                switch result {
//                case .success:
//                    self?.showSuccess(message: "Request sent to \(user.name)")
//                case .failure(let error):
//                    self?.showError(message: error.localizedDescription)
//                }
//            }
//        }
    }
}

extension AddContactViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactSearchCell", for: indexPath) as! ContactSearchCell
        cell.configure(with: searchResults[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let user = searchResults[indexPath.row]
        showContactActionSheet(for: user)
    }
    
    private func showContactActionSheet(for user: ChatPartner) {
        let alert = UIAlertController(
            title: user.name,
            message: "Add \(user.name) to your contacts?",
            preferredStyle: .actionSheet
        )
        
        alert.addAction(UIAlertAction(title: "Send Contact Request", style: .default) { [weak self] _ in
            self?.sendContactRequest(to: user)
        })
        
        alert.addAction(UIAlertAction(title: "View Profile", style: .default) { [weak self] _ in
            self?.navigateToProfile(userId: user.id)
        })
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(alert, animated: true)
    }
    
    private func navigateToProfile(userId: Int) {
//        let profileVC = ProfileViewController(userId: userId)
//        navigationController?.pushViewController(profileVC, animated: true)
    }
}

extension AddContactViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(executeSearch), object: nil)
        perform(#selector(executeSearch), with: nil, afterDelay: 0.5)
    }
    
    @objc private func executeSearch() {
        performSearch(query: searchBar.text ?? "")
    }
}

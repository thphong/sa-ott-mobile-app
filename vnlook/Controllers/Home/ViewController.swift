//
//  ViewController.swift
//  vnlook
//
//  Created by Nguyễn Minh Tâm on 08/01/2024.
//

import UIKit

class HomeViewController: UIViewController {
    private var topContentView: UIView!
    private var subContentView: UIView!
    private var searchBar: UISearchBar!
    private var tableView: UITableView!
    
    override func loadView() {
        super.loadView()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "line.3.horizontal"), style: .plain, target: nil, action: #selector(menuAction))
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "person.crop.circle"), style: .plain, target: nil, action: #selector(menuAction)),
            UIBarButtonItem(image: UIImage(systemName: "bell"), style: .plain, target: nil, action: #selector(menuAction))
        ]
        
        topContentView = UIView()
        topContentView.backgroundColor = UIColor(hexString: "#04555C")
        topContentView.translatesAutoresizingMaskIntoConstraints = false
        
        subContentView = UIView()
        subContentView.backgroundColor = .white
        subContentView.translatesAutoresizingMaskIntoConstraints = false
        
        searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.backgroundColor = .white
        searchBar.searchTextField.backgroundColor = .clear
        searchBar.layer.cornerRadius = 10
        searchBar.clipsToBounds = true
        searchBar.placeholder = "Search"
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(SubcateTableViewCell.self, forCellReuseIdentifier: String(describing: SubcateTableViewCell.self))
        tableView.register(PlaceTableViewCell.self, forCellReuseIdentifier: String(describing: PlaceTableViewCell.self))
        tableView.register(RecommendTableViewCell.self, forCellReuseIdentifier: String(describing: RecommendTableViewCell.self))
        
        subContentView.addSubview(tableView)
        view.addSubview(topContentView)
        view.addSubview(subContentView)
        view.addSubview(searchBar)
        
        NSLayoutConstraint.activate([
            topContentView.topAnchor.constraint(equalTo: view.topAnchor),
            topContentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topContentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topContentView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1 / 4),
            
            subContentView.topAnchor.constraint(equalTo: topContentView.bottomAnchor),
            subContentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            subContentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            subContentView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            searchBar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            searchBar.centerYAnchor.constraint(equalTo: subContentView.topAnchor),
            searchBar.heightAnchor.constraint(equalToConstant: 40),
            searchBar.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 2 / 3),
            
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: subContentView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: subContentView.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: subContentView.bottomAnchor),
            
        ])
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @objc private func menuAction() {
        
    }
}

extension HomeViewController: UITableViewDelegate {}

extension HomeViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SubcateTableViewCell.self), for: indexPath)
            return cell
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PlaceTableViewCell.self), for: indexPath)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RecommendTableViewCell.self), for: indexPath)
            return cell
        }
    }
}

extension HomeViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text {
            print("Search text: \(searchText)")
        }
        
        searchBar.resignFirstResponder() // Hide the keyboard
    }
}

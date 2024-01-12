//
//  HomeViewController.swift
//  vnlook
//
//  Created by Nguyễn Minh Tâm on 10/01/2024.
//

import UIKit

final class HomeViewController: BaseViewController {
    private var topContentView: UIView!
    private var subContentView: UIView!
    private var searchBar: UISearchBar!
    private var tableView: UITableView!
    private var lblTitle: UILabel!
    private var mockData = PlaceModel()
    
    override func loadView() {
        super.loadView()
        
        topContentView = UIView()
        topContentView.backgroundColor = UIColor(hexString: "#025959")
        topContentView.translatesAutoresizingMaskIntoConstraints = false
        
        subContentView = UIView()
        subContentView.backgroundColor = .white
        subContentView.translatesAutoresizingMaskIntoConstraints = false
        
        searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.backgroundColor = UIColor(hexString: "#D99962")
        searchBar.searchTextField.backgroundColor = .clear
        searchBar.layer.cornerRadius = 10
        searchBar.clipsToBounds = true
        searchBar.placeholder = "Search"
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        lblTitle = UILabel()
        lblTitle.text = "Explore the beautiful places"
        lblTitle.textColor = UIColor(hexString: "#F2EBDC")
        lblTitle.font = .interBold(24)
        lblTitle.numberOfLines = 2
        lblTitle.translatesAutoresizingMaskIntoConstraints = false
        
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.isScrollEnabled = false
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(SubcateTableViewCell.self, forCellReuseIdentifier: String(describing: SubcateTableViewCell.self))
        tableView.register(PlaceTableViewCell.self, forCellReuseIdentifier: String(describing: PlaceTableViewCell.self))
        tableView.register(RecommendTableViewCell.self, forCellReuseIdentifier: String(describing: RecommendTableViewCell.self))
        
        topContentView.addSubview(lblTitle)
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
            
            lblTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            lblTitle.leadingAnchor.constraint(equalTo: topContentView.leadingAnchor, constant: 16),
            lblTitle.widthAnchor.constraint(equalTo: topContentView.widthAnchor, multiplier: 1 / 2),
            
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 8),
            tableView.leadingAnchor.constraint(equalTo: subContentView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: subContentView.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: subContentView.bottomAnchor),
            
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SubcateTableViewCell.self), for: indexPath) as! SubcateTableViewCell
            cell.delegate = self
            return cell
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PlaceTableViewCell.self), for: indexPath) as! PlaceTableViewCell
            cell.setData(mockData)
            cell.delegate = self
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RecommendTableViewCell.self), for: indexPath) as! RecommendTableViewCell
            cell.setData(mockData)
            cell.delegate = self
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

extension HomeViewController: PlaceTableViewCellDelegate {
    func onDataSelected(_ data: PlaceModel) {
        let vc = DetailViewController(data)
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension HomeViewController: SubcateTableViewCellDelegate {
    func onDataSelected() {
        let vc = ListViewController()
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension HomeViewController: RecommendTableViewCellDelegate {
    func onRecommendSelected(_ data: PlaceModel) {
        let vc = DetailViewController(data)
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

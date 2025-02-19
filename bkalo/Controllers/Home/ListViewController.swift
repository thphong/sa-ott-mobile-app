//
//  ListViewController.swift
//  bkalo
//
//  Created by Nguyễn Minh Tâm on 11/01/2024.
//

import UIKit

final class ListViewController: UIViewController {
    private var tableView: UITableView!
    private var mockDatas: [PlaceModel] = [
        PlaceModel(),
        PlaceModel(),
        PlaceModel()
    ]
    
    override func loadView() {
        super.loadView()
        
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor(hexString: "#5DA6A6")
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.alwaysBounceHorizontal = false
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(PlaceListTableViewCell.self, forCellReuseIdentifier: String(describing: PlaceListTableViewCell.self))
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(hexString: "#5DA6A6")
        navigationItem.title = "South"
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes as [NSAttributedString.Key : Any]
    }
}

extension ListViewController: UITableViewDelegate {
    
}

extension ListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mockDatas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PlaceListTableViewCell.self), for: indexPath) as! PlaceListTableViewCell
        cell.delegate = self
        cell.setData(mockDatas[indexPath.row])
        return cell
    }
}

extension ListViewController: PlaceListTableViewCellDelegate {
    func onDataSelected(_ data: PlaceModel) {
        let vc = DetailViewController(data)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

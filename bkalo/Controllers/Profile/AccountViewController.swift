//
//  AccountViewController.swift
//  bkalo
//
//  Created by Nguyễn Minh Tâm on 10/01/2024.
//

import UIKit

final class AccountViewController: BaseViewController {
    
    private var topView: UIView!
    private var tableView: UITableView!
    
    // ------------ MOCK DATA ------------
    private var mockDataLst = [
        AccountItemModel(icon: "cloud", title: "Cloud của tôi", isMore: true),
        AccountItemModel(icon: "staroflife.shield", title: "Tài khoản và bảo mật", isMore: true),
        AccountItemModel(icon: "exclamationmark.lock", title: "Quyền riêng tư", isMore: true)
    ]
    
    override func loadView() {
        super.loadView()
        
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "gearshape"), style: .plain, target: self, action: #selector(settingAction)),
            UIBarButtonItem()
        ]
        
        topView = UIView()
        topView.backgroundColor = UIColor(hexString: "#4396F4")
        topView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(AccountSectionHeaderView.self, forHeaderFooterViewReuseIdentifier: String(describing: AccountSectionHeaderView.self))
        tableView.register(AccountTableViewCell.self, forCellReuseIdentifier: String(describing: AccountTableViewCell.self))
        
        view.addSubview(topView)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            topView.topAnchor.constraint(equalTo: view.topAnchor),
            topView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 3 / 25),
            
            tableView.topAnchor.constraint(equalTo: topView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(hexString: "#F2F5F7")
    }

    @objc private func settingAction() {

    }
}

extension AccountViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 72
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: String(describing: AccountSectionHeaderView.self)) as! AccountSectionHeaderView
        header.setData()
        return header
    }
}

extension AccountViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: AccountTableViewCell.self), for: indexPath) as! AccountTableViewCell
        cell.setData(mockDataLst[indexPath.row])
        return cell
    }
}

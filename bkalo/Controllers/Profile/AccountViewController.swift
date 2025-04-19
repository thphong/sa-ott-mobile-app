//
//  AccountViewController.swift
//  bkalo
//
//  Created by Nguyễn Minh Tâm on 10/01/2024.
//

import UIKit
import FirebaseAuth

final class AccountViewController: BaseViewController {
    
    private var tableView: UITableView!
    private var btnLogout: UIButton!
    private var userData: UserModel?
    
    // ------------ MOCK DATA ------------
    private var mockDataLst = [
        AccountItemModel(icon: "cloud", title: "My Cloud", isMore: true, actionType: .cloud),
        AccountItemModel(icon: "staroflife.shield", title: "Account and Security", isMore: true, actionType: .security),
        AccountItemModel(icon: "exclamationmark.lock", title: "Privacy", isMore: true, actionType: .privacy)
    ]
    
    override func loadView() {
        super.loadView()
        
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "gearshape"), style: .plain, target: self, action: #selector(settingAction)),
            UIBarButtonItem()
        ]
        
        tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(AccountSectionHeaderView.self, forHeaderFooterViewReuseIdentifier: String(describing: AccountSectionHeaderView.self))
        tableView.register(AccountTableViewCell.self, forCellReuseIdentifier: String(describing: AccountTableViewCell.self))
        
        let logoutTitle = "Log out"
        let logoutAttrs = [NSAttributedString.Key.font: UIFont.interMedium(18), NSAttributedString.Key.foregroundColor: UIColor.white]
        let logoutString = NSMutableAttributedString(string: logoutTitle, attributes: logoutAttrs as [NSAttributedString.Key : Any])
        
        btnLogout = UIButton(type: .system)
        btnLogout.backgroundColor = .gray
        btnLogout.setAttributedTitle(logoutString, for: .normal)
        btnLogout.layer.cornerRadius = 10
        btnLogout.translatesAutoresizingMaskIntoConstraints = false
        btnLogout.addTarget(self, action: #selector(actionLogout), for: .touchUpInside)
        
        view.addSubview(tableView)
        view.addSubview(btnLogout)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: btnLogout.topAnchor, constant: -8),
            
            btnLogout.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            btnLogout.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            btnLogout.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            btnLogout.heightAnchor.constraint(equalToConstant: 48)
        ])
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .iceBlue
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UserService.shared.getCurrentInfo { success, userData in
            if success {
                self.userData = userData
                self.tableView.reloadData()
            }
        }
    }

    @objc private func settingAction() {

    }
    
    @objc private func actionLogout() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            AuthenManager.clearAuthModel()
            AuthenManager.shared.logoutApp { success in
                guard success else { return }
                SceneDelegate.sharedInstance?.setRootLoginVC()
            }
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
    
    @objc private func didTapHeader() {
        let updateVC = ProfileViewController()
        navigationController?.pushViewController(updateVC, animated: true)
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
        
        if let userData = self.userData {
            header.setData(userData)
        }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapHeader))
        header.addGestureRecognizer(tapGesture)
        header.isUserInteractionEnabled = true
        
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedItem = mockDataLst[indexPath.row]
        
        switch selectedItem.actionType {
        case .cloud:
            showComingSoonAlert(for: "My Cloud")
        case .security:
            showComingSoonAlert(for: "Account and Security")
        case .privacy:
            showComingSoonAlert(for: "Privacy")
        }
    }
}

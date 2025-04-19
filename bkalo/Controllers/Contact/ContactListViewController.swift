//
//  ContactListViewController.swift
//  bkalo
//
//  Created by Nguyen Minh Tam on 19/2/25.
//

import UIKit

final class ContactListViewController: BaseViewController {
    
    private var tableView: UITableView!
    private var contacts: [ChatPartner] = []
    
    override func loadView() {
        super.loadView()
        
        tableView = UITableView(frame: .zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        // tableView.register(ContactSectionHeaderView.self, forHeaderFooterViewReuseIdentifier: String(describing: ContactSectionHeaderView.self))
        tableView.register(ContactTableViewCell.self, forCellReuseIdentifier: String(describing: ContactTableViewCell.self))
        
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
        fetchContacts()
    }
    
//    private func fetchContacts() {
//        ContactService.shared.getFriends { [weak self] success, contacts in
//            guard let self = self else { return }
//            
//            DispatchQueue.main.async {
//                if success, let contacts = contacts, !contacts.isEmpty {
//                    self.contacts = contacts
//                    self.tableView.reloadData()
//                } else {
//                    self.contacts = []
//                    print("Failed to fetch contacts or empty response")
//                    self.showEmptyStateIfNeeded()
//                }
//            }
//        }
//    }
    
    private func fetchContacts() {
        ContactService.shared.getFriends { [weak self] success, contacts in
            guard let self = self else { return }

            guard success, let contacts = contacts, !contacts.isEmpty else {
                DispatchQueue.main.async {
                    self.contacts = []
                    print("Failed to fetch contacts or empty response")
                    self.showEmptyStateIfNeeded()
                }
                return
            }

            let group = DispatchGroup()
            var updatedContacts: [ChatPartner] = []

            for var partner in contacts {
                group.enter()
                ChatSocketManager.shared.getPublicFile(key: partner.avatarURL ?? "") { success, publicURL in
                    if success, let publicKey = publicURL {
                        partner.fullAvatarURL = publicKey
                    } else {
                        print("No public key for user \(partner.id)")
                    }
                    updatedContacts.append(partner)
                    group.leave()
                }
            }

            group.notify(queue: .main) {
                self.contacts = updatedContacts
                self.tableView.reloadData()
            }
        }
    }


    private func showEmptyStateIfNeeded() {
        if contacts.isEmpty {
            let view = EmptyStateView()
            view.configure(
                image: nil,
                title: "No Contacts Found",
                subtitle: "Try adding some phone numbers to your contacts to see them here."
            )
            tableView.backgroundView = view
        } else {
            tableView.backgroundView = nil
        }
    }
}

extension ContactListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let chatVC = ChatViewController(chatPartner: contacts[indexPath.row])
        chatVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(chatVC, animated: true)
    }
    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 48
//    }
//    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: String(describing: ContactSectionHeaderView.self)) as! ContactSectionHeaderView
//        header.setData()
//        return header
//    }
}

extension ContactListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return contacts.isEmpty ? 0 : 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ContactTableViewCell.self), for: indexPath) as! ContactTableViewCell
        cell.setData(contacts[indexPath.row])
        return cell
    }
}

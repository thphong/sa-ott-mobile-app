//
//  GroupListViewController.swift
//  bkalo
//
//  Created by Nguyen Minh Tam on 16/4/25.
//

import UIKit

final class GroupListViewController: BaseViewController {

    private var tableView: UITableView!
    private var groups: [GroupChat] = []
    private var page: Int = 0
    private var limit: Int = 10
    private var isLoading = false
    private var footerSpinner: UIActivityIndicatorView!

    override func loadView() {
        super.loadView()

        tableView = UITableView(frame: .zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.register(GroupChatTableViewCell.self, forCellReuseIdentifier: String(describing: GroupChatTableViewCell.self))

        footerSpinner = UIActivityIndicatorView(style: .medium)
        footerSpinner.translatesAutoresizingMaskIntoConstraints = false
        footerSpinner.hidesWhenStopped = true
        
        tableView.addSubview(footerSpinner)
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
        fetchGroupChats()
    }

    private func fetchGroupChats() {
        guard !isLoading else { return }
        isLoading = true
        footerSpinner.startAnimating()

        ContactService.shared.getGroups(page: page, limit: limit) { [weak self] success, groups in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.isLoading = false
                self.footerSpinner.stopAnimating()

                if success, let groups = groups, !groups.isEmpty {
                    self.groups.append(contentsOf: groups)
                    self.page += 1
                    self.tableView.reloadData()
                } else {
                    self.showEmptyStateIfNeeded()
                }
            }
        }
    }

    private func showEmptyStateIfNeeded() {
        if groups.isEmpty {
            let view = EmptyStateView()
            view.configure(
                image: nil,
                title: "No Group Chats Yet",
                subtitle: "Start a new group chat to see it appear here."
            )
            tableView.backgroundView = view
        } else {
            tableView.backgroundView = nil
        }
    }
}

extension GroupListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let chatVC = ChatViewController(groupChat: groups[indexPath.row])
        chatVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(chatVC, animated: true)
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == groups.count - 1 {
            fetchGroupChats()
        }
    }
}

extension GroupListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: GroupChatTableViewCell.self), for: indexPath) as! GroupChatTableViewCell
        cell.setData(groups[indexPath.row])
        return cell
    }
}



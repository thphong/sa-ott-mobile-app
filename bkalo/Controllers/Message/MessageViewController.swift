//
//  MessageViewController.swift
//  bkalo
//
//  Created by Nguyen Minh Tam on 18/2/25.
//

import UIKit
import SwipeCellKit

final class MessageViewController: BaseViewController {
    
    private var topView: UIView!
    private var tableView: UITableView!
    
    override func loadView() {
        super.loadView()
        
        topView = UIView()
        topView.backgroundColor = UIColor(hexString: "#4396F4")
        topView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(MessageSectionHeaderView.self, forHeaderFooterViewReuseIdentifier: String(describing: MessageSectionHeaderView.self))
        tableView.register(MessageTableViewCell.self, forCellReuseIdentifier: String(describing: MessageTableViewCell.self))
        
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
}

extension MessageViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 48
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: String(describing: MessageSectionHeaderView.self)) as! MessageSectionHeaderView
        return header
    }
}

extension MessageViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MessageTableViewCell.self), for: indexPath) as! MessageTableViewCell
        cell.delegate = self
        cell.setData()
        return cell
    }
}

extension MessageViewController: SwipeTableViewCellDelegate {
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        
        let deleteAction = SwipeAction(style: .destructive, title: "Xóa") { action, indexPath in
            // handle action by updating model with deletion
        }
        deleteAction.image = UIImage(systemName: "trash")
        
        let moreAction = SwipeAction(style: .destructive, title: "Thêm") { action, indexPath in
            
        }
        moreAction.image = UIImage(systemName: "ellipsis")
        moreAction.backgroundColor = UIColor(hexString: "#ccd1d6")
        
        let unreadAction = SwipeAction(style: .destructive, title: "Chưa đọc") { action, indexPath in
            
        }
        unreadAction.image = UIImage(systemName: "message.badge.filled.fill")
        unreadAction.backgroundColor = UIColor(hexString: "#3B86F7")
        
        return [unreadAction, deleteAction, moreAction]
    }
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .destructive
        options.transitionStyle = .border
        return options
    }
}

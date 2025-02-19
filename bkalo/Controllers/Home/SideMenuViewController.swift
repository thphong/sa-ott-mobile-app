//
//  SideMenuViewController.swift
//  bkalo
//
//  Created by Nguyễn Minh Tâm on 10/01/2024.
//

import UIKit

protocol SideMenuViewControllerDelegate {
    func selectedCell(_ row: Int)
}

final class SideMenuViewController: UIViewController {
    private var topView: UIView!
    private var bottomView: UIView!
    private var imgAvatar: UIImageView!
    private var lblUsername: UILabel!
    private var lblEmail: UILabel!
    private var lblAuthor: UILabel!
    private var tableView: UITableView!
    private var menus: [SideMenuModel] = [
        SideMenuModel(icon: UIImage(systemName: "house.fill")!, title: "Home"),
        SideMenuModel(icon: UIImage(systemName: "person.fill")!, title: "Profile"),
        SideMenuModel(icon: UIImage(systemName: "person.2.fill")!, title: "About Us"),
        SideMenuModel(icon: UIImage(systemName: "phone.fill")!, title: "Contact Us"),
        SideMenuModel(icon: UIImage(systemName: "rectangle.portrait.and.arrow.right.fill")!, title: "Sign Out")
    ]
    
    var delegate: SideMenuViewControllerDelegate?
    
    override func loadView() {
        super.loadView()
        
        view.backgroundColor = .white
        
        topView = UIView()
        topView.backgroundColor = UIColor(hexString: "#027368")
        topView.translatesAutoresizingMaskIntoConstraints = false
        
        bottomView = UIView()
        bottomView.backgroundColor = UIColor(hexString: "#5DA6A6")
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        
        imgAvatar = UIImageView()
        imgAvatar.image = UIImage(named: "testing")?.withRenderingMode(.alwaysOriginal)
        imgAvatar.contentMode = .scaleAspectFill
        imgAvatar.layer.masksToBounds = true
        imgAvatar.translatesAutoresizingMaskIntoConstraints = false
        
        lblUsername = UILabel()
        lblUsername.text = "tamnguyen"
        lblUsername.font = .interBold(14)
        lblUsername.textColor = UIColor(hexString: "F2EBBC")
        lblUsername.translatesAutoresizingMaskIntoConstraints = false
        
        lblEmail = UILabel()
        lblEmail.text = "tamnguyen@vnpt.vn"
        lblEmail.font = .interRegular(12)
        lblEmail.textColor = UIColor(hexString: "F2EBBC")
        lblEmail.translatesAutoresizingMaskIntoConstraints = false
        
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor(hexString: "#5DA6A6")
        tableView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.isScrollEnabled = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(SideMenuTableViewCell.self, forCellReuseIdentifier: String(describing: SideMenuTableViewCell.self))
        
        lblAuthor = UILabel()
        lblAuthor.text = "Developed by Tam Nguyen"
        lblAuthor.font = .interMedium(14)
        lblAuthor.textColor = UIColor(hexString: "F2EBBC")
        lblAuthor.translatesAutoresizingMaskIntoConstraints = false
        
        let detailView = UIStackView()
        detailView.axis = .vertical
        detailView.translatesAutoresizingMaskIntoConstraints = false
        
        detailView.addArrangedSubview(lblUsername)
        detailView.addArrangedSubview(lblEmail)
        topView.addSubview(imgAvatar)
        topView.addSubview(detailView)
        bottomView.addSubview(tableView)
        bottomView.addSubview(lblAuthor)
        view.addSubview(topView)
        view.addSubview(bottomView)
        
        NSLayoutConstraint.activate([
            topView.topAnchor.constraint(equalTo: view.topAnchor),
            topView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1 / 4),
            
            bottomView.topAnchor.constraint(equalTo: topView.bottomAnchor),
            bottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            imgAvatar.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 16),
            imgAvatar.centerYAnchor.constraint(equalTo: topView.centerYAnchor),
            imgAvatar.heightAnchor.constraint(equalTo: topView.heightAnchor, multiplier: 1 / 3),
            imgAvatar.widthAnchor.constraint(equalTo: imgAvatar.heightAnchor),
            
            detailView.leadingAnchor.constraint(equalTo: imgAvatar.trailingAnchor, constant: 16),
            detailView.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -8),
            detailView.centerYAnchor.constraint(equalTo: topView.centerYAnchor),
            
            tableView.topAnchor.constraint(equalTo: bottomView.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: lblAuthor.topAnchor),
            
            lblAuthor.centerXAnchor.constraint(equalTo: bottomView.centerXAnchor),
            lblAuthor.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor, constant: -32)
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imgAvatar.layer.cornerRadius = imgAvatar.bounds.height / 2
    }

}

extension SideMenuViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.selectedCell(indexPath.row)
    }
}

extension SideMenuViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menus.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SideMenuTableViewCell.self), for: indexPath) as! SideMenuTableViewCell
        cell.setData(menus[indexPath.row])
        return cell
    }
}

//
//  BaseViewController.swift
//  bkalo
//
//  Created by Nguyễn Minh Tâm on 08/01/2024.
//

import UIKit

class BaseViewController: UIViewController {
    private var searchBar: UISearchBar!
    
    override func loadView() {
        super.loadView()
        
        searchBar = UISearchBar(frame: CGRectMake(0, 0, 280, 20))
        searchBar.delegate = self
        searchBar.backgroundColor = .clear
        searchBar.searchTextField.backgroundColor = .clear
        searchBar.searchTextField.leftView?.tintColor = .white
        searchBar.searchTextField.attributedPlaceholder =  NSAttributedString.init(string: "Tìm kiếm", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: searchBar)
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(profileAction)),
            UIBarButtonItem(image: UIImage(systemName: "qrcode.viewfinder"), style: .plain, target: self, action: #selector(notifyAction))
        ]
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .cornFlowerBlue
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.barTintColor = .cornFlowerBlue
    }
    
    deinit {
        navigationController?.navigationBar.delegate = nil
    }
    
    @objc private func profileAction() {
        let vc = ProfileViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func notifyAction() {

    }
}

extension BaseViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text {
            print("Search text: \(searchText)")
        }
        
        searchBar.resignFirstResponder()
    }
}


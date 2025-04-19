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
        searchBar.searchTextField.attributedPlaceholder =  NSAttributedString.init(string: "Search", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: searchBar)
        
        let btnAdd = UIButton.barButton(image: UIImage(systemName: "plus"))
        btnAdd.tintColor = .white
        btnAdd.addTarget(self, action: #selector(profileAction), for: .touchUpInside)
        
        let btnQR = UIButton.barButton(image: UIImage(systemName: "qrcode.viewfinder"))
        btnQR.tintColor = .white
        btnQR.addTarget(self, action: #selector(notifyAction), for: .touchUpInside)
        
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(customView: btnAdd),
            UIBarButtonItem(customView: btnQR)
        ]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    // Helper function to show the "Coming Soon" alert
    public func showComingSoonAlert(for section: String) {
        let alertController = UIAlertController(title: "\(section)", message: "This feature is coming soon.", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(action)
        
        present(alertController, animated: true, completion: nil)
    }
}

extension BaseViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text {
            print("Search text: \(searchText)")
        }
        
        searchBar.resignFirstResponder()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
        let alert = UIAlertController(
            title: "Coming soon",
            message: "Search feature is under development. Please check back soon!",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}


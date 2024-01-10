//
//  ViewController.swift
//  vnlook
//
//  Created by Nguyễn Minh Tâm on 08/01/2024.
//

import UIKit
import SideMenu

class BaseViewController: UIViewController {
    
    override func loadView() {
        super.loadView()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "line.3.horizontal"), style: .plain, target: self, action: #selector(menuAction))
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "person.crop.circle"), style: .plain, target: self, action: #selector(profileAction)),
            UIBarButtonItem(image: UIImage(systemName: "bell"), style: .plain, target: self, action: #selector(notifyAction))
        ]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @objc private func profileAction() {
        let vc = ProfileViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func menuAction() {
        let vc = SideMenuViewController()
        let menu = SideMenuNavigationController(rootViewController: vc)
        menu.leftSide = true
        present(menu, animated: true)
    }
    
    @objc private func notifyAction() {
        let vc = DetailViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

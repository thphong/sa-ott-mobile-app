//
//  ContactViewController.swift
//  bkalo
//
//  Created by Nguyen Minh Tam on 19/2/25.
//

import UIKit
import PagingKit

final class ContactViewController: BaseViewController {
    
    private var menuVC: PagingMenuViewController!
    private var contentVC: PagingContentViewController!
    private var contentVCs = [ContactListViewController(), ContactListViewController()]
    private var contactCategoryModels = ["Bạn bè", "Nhóm"]
    
    override func loadView() {
        super.loadView()
        
        let focusView = UnderlineFocusView()
        focusView.underlineHeight = 2
        focusView.underlineColor = .royalBlue
        focusView.backgroundColor = .clear
        
        menuVC = PagingMenuViewController()
        menuVC.delegate = self
        menuVC.dataSource = self
        menuVC.cellAlignment = .center
        menuVC.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        menuVC.view.translatesAutoresizingMaskIntoConstraints = false
        menuVC.register(type: CategoryMenuCell.self, forCellWithReuseIdentifier: String(describing: CategoryMenuCell.self))
        menuVC.registerFocusView(view: focusView, isBehindCell: true)
        
        contentVC = PagingContentViewController()
        contentVC.delegate = self
        contentVC.dataSource = self
        contentVC.view.translatesAutoresizingMaskIntoConstraints = false
        
        addChild(menuVC)
        addChild(contentVC)
        
        view.addSubview(menuVC.view)
        view.addSubview(contentVC.view)
        
        NSLayoutConstraint.activate([
            menuVC.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            menuVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            menuVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            menuVC.view.heightAnchor.constraint(equalToConstant: 44),
            
            contentVC.view.topAnchor.constraint(equalTo: menuVC.view.bottomAnchor),
            contentVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentVC.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .iceBlue
        
        menuVC.didMove(toParent: self)
        contentVC.didMove(toParent: self)
        
        menuVC.reloadData()
        contentVC.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "person.badge.plus"), style: .plain, target: self, action: #selector(addContactAction)),
            UIBarButtonItem()
        ]
    }
    
    @objc private func addContactAction() {}
}

extension ContactViewController: PagingMenuViewControllerDelegate {
    func menuViewController(viewController: PagingMenuViewController, didSelect page: Int, previousPage: Int) {
        contentVC.scroll(to: page, animated: true)
    }
}

extension ContactViewController: PagingMenuViewControllerDataSource {
    func numberOfItemsForMenuViewController(viewController: PagingMenuViewController) -> Int {
        print("contactModels.count: \(contactCategoryModels.count)")
        return contactCategoryModels.count
    }
    
    func menuViewController(viewController: PagingMenuViewController, cellForItemAt index: Int) -> PagingMenuViewCell {
        let cell = viewController.dequeueReusableCell(withReuseIdentifier: String(describing: CategoryMenuCell.self), for: index) as! CategoryMenuCell
        cell.setData(contactCategoryModels[index])
        return cell
    }
    
    func menuViewController(viewController: PagingKit.PagingMenuViewController, widthForItemAt index: Int) -> CGFloat {
        return UIScreen.main.bounds.width / CGFloat(contactCategoryModels.count)
    }
}

extension ContactViewController: PagingContentViewControllerDelegate {
    func contentViewController(viewController: PagingContentViewController, didManualScrollOn index: Int, percent: CGFloat) {
        menuVC.scroll(index: index, percent: percent, animated: true)
    }
    
    func contentViewController(viewController: PagingContentViewController, didFinishPagingAt index: Int, animated: Bool) {
        
    }
}

extension ContactViewController: PagingContentViewControllerDataSource {
    func numberOfItemsForContentViewController(viewController: PagingContentViewController) -> Int {
        print("contentVCs.count: \(contentVCs.count)")
        return contentVCs.count
    }
    
    func contentViewController(viewController: PagingContentViewController, viewControllerAt index: Int) -> UIViewController {
        return contentVCs[index]
    }
}

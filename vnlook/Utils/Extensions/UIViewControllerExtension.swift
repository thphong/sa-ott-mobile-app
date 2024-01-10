//
//  UIViewControllerExtension.swift
//  vnlook
//
//  Created by Nguyễn Minh Tâm on 10/01/2024.
//

import UIKit

extension UIViewController {
    func presentToParent(_ parentViewController: UIViewController) {
        view.translatesAutoresizingMaskIntoConstraints = false
        
        parentViewController.addChild(self)
        parentViewController.view.addSubview(view)
        
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: parentViewController.view.topAnchor),
            view.leadingAnchor.constraint(equalTo: parentViewController.view.leadingAnchor),
            // view.trailingAnchor.constraint(equalTo: parentViewController.view.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: parentViewController.view.bottomAnchor),
            view.widthAnchor.constraint(equalTo: parentViewController.view.widthAnchor, multiplier: 1 / 4)
        ])
        
        view.transform = CGAffineTransform(translationX: 0, y: parentViewController.view.bounds.height)
        view.layer.zPosition = .greatestFiniteMagnitude
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.25, animations: { [weak self] in
            self?.view.transform = .identity
        }, completion: { [weak self] _ in
            self?.didMove(toParent: parentViewController)
        })
    }
}

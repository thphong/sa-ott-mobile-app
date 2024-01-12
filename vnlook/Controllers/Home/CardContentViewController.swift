//
//  CardContentViewController.swift
//  vnlook
//
//  Created by Nguyen Minh Tam on 11/01/2024.
//

import UIKit

class CardContentViewController: UIViewController {
    private var lblTitle: UILabel!
    private var lblDesc: UILabel!
    private var authorModel: AuthorModel!
    
    init(_ data: AuthorModel) {
        super.init(nibName: nil, bundle: nil)
        authorModel = data
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
       
        lblTitle = UILabel()
        lblTitle.text = authorModel.name
        lblTitle.font = .interBold(24)
        lblTitle.textColor = .red
        lblTitle.translatesAutoresizingMaskIntoConstraints = false
        
        lblDesc = UILabel()
        lblDesc.text = authorModel.desc
        lblDesc.font = .interRegular(16)
        lblDesc.textColor = .black
        lblDesc.numberOfLines = 0
        lblDesc.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(lblTitle)
        view.addSubview(lblDesc)
        
        NSLayoutConstraint.activate([
            lblTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
            lblTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            lblDesc.topAnchor.constraint(equalTo: lblTitle.bottomAnchor, constant: 16),
            lblDesc.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            lblDesc.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}

//
//  ContactSectionHeaderView.swift
//  bkalo
//
//  Created by Nguyen Minh Tam on 19/2/25.
//

import UIKit

final class ContactSectionHeaderView: UITableViewHeaderFooterView {
    
    private var lblTitle: UILabel!
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configureContents()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureContents()
    }
    
    private func configureContents() {
        contentView.backgroundColor = .white
        
        lblTitle = UILabel()
        lblTitle.font = .interMedium(16)
        lblTitle.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(lblTitle)
        
        NSLayoutConstraint.activate([
            lblTitle.topAnchor.constraint(equalTo: contentView.topAnchor),
            lblTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            lblTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            lblTitle.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func setData() {
        self.lblTitle.text = "D"
    }
}

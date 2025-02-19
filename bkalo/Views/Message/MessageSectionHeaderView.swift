//
//  MessageSectionHeaderView.swift
//  bkalo
//
//  Created by Nguyen Minh Tam on 18/2/25.
//

import UIKit

final class MessageSectionHeaderView: UITableViewHeaderFooterView {
    
    private var btnFilter: UIButton!
    
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
        
        let titleLabel = UILabel()
        titleLabel.text = "Tất cả"
        titleLabel.font = .interMedium(16)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        btnFilter = UIButton(type: .system)
        btnFilter.setImage(UIImage(named: "ic_filter")?.withRenderingMode(.alwaysOriginal), for: .normal)
        btnFilter.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(btnFilter)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            btnFilter.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            btnFilter.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            btnFilter.heightAnchor.constraint(equalToConstant: 24),
            btnFilter.widthAnchor.constraint(equalToConstant: 24),
        ])
    }
}

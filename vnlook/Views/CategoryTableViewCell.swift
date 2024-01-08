//
//  CategoryTableViewCell.swift
//  vnlook
//
//  Created by Nguyễn Minh Tâm on 08/01/2024.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {
    private var topContentView: UIView!
    private (set) var subContentView: UIView!
    private var lblTitle: UILabel!
    private var btnMore: UIButton!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureContents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureContents() {
        lblTitle = UILabel()
        lblTitle.text = "Regions"
        lblTitle.font = .interBold(16)
        lblTitle.textColor = .black
        lblTitle.translatesAutoresizingMaskIntoConstraints = false
        
        btnMore = UIButton(type: .system)
        btnMore.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        btnMore.tintColor = .black
        btnMore.addTarget(self, action: #selector(moreTapped), for: .touchUpInside)
        btnMore.translatesAutoresizingMaskIntoConstraints = false
        
        topContentView = UIView()
        topContentView.translatesAutoresizingMaskIntoConstraints = false
        
        subContentView = UIView()
        subContentView.translatesAutoresizingMaskIntoConstraints = false
        
        topContentView.addSubview(lblTitle)
        topContentView.addSubview(btnMore)
        
        let stackView = UIStackView(arrangedSubviews: [topContentView, subContentView])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            lblTitle.topAnchor.constraint(equalTo: topContentView.topAnchor),
            lblTitle.leadingAnchor.constraint(equalTo: topContentView.leadingAnchor, constant: 16),
            lblTitle.bottomAnchor.constraint(equalTo: topContentView.bottomAnchor),
            
            btnMore.topAnchor.constraint(equalTo: topContentView.topAnchor),
            btnMore.trailingAnchor.constraint(equalTo: topContentView.trailingAnchor, constant: -16),
            btnMore.bottomAnchor.constraint(equalTo: topContentView.bottomAnchor),
            
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            
        ])
    }
    
    @objc func moreTapped() {}
}

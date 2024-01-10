//
//  SideMenuTableViewCell.swift
//  vnlook
//
//  Created by Nguyen Minh Tam on 10/01/2024.
//

import UIKit

class SideMenuTableViewCell: UITableViewCell {
    private var imgView: UIImageView!
    private var lblTitle: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureContents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureContents() {
        selectionStyle = .none
        backgroundColor = .clear
        
        imgView = UIImageView()
        imgView.tintColor = UIColor(hexString: "F2EBBC")
        imgView.translatesAutoresizingMaskIntoConstraints = false
        
        lblTitle = UILabel()
        lblTitle.font = .interMedium(14)
        lblTitle.textColor = UIColor(hexString: "F2EBBC")
        lblTitle.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(imgView)
        contentView.addSubview(lblTitle)
        
        NSLayoutConstraint.activate([
            imgView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            imgView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imgView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            lblTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            lblTitle.leadingAnchor.constraint(equalTo: imgView.trailingAnchor, constant: 16),
            lblTitle.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    func setData(_ data: SideMenuModel) {
        imgView.image = data.icon
        lblTitle.text = data.title
    }
}

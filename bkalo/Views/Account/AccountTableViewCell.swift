//
//  AccountTableViewCell.swift
//  bkalo
//
//  Created by Nguyen Minh Tam on 18/2/25.
//

import UIKit

final class AccountTableViewCell: UITableViewCell {
    
    private var imgIcon: UIImageView!
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
        imgIcon = UIImageView()
        imgIcon.contentMode = .center
        imgIcon.layer.masksToBounds = true
        imgIcon.clipsToBounds = true
        imgIcon.translatesAutoresizingMaskIntoConstraints = false
        
        lblTitle = UILabel()
        lblTitle.font = .interRegular(16)
        lblTitle.translatesAutoresizingMaskIntoConstraints = false
        
        btnMore = UIButton(type: .system)
        btnMore.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        btnMore.tintColor = UIColor(hexString: "#989898")
        btnMore.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(imgIcon)
        contentView.addSubview(lblTitle)
        contentView.addSubview(btnMore)
        
        NSLayoutConstraint.activate([
            imgIcon.topAnchor.constraint(equalTo: contentView.topAnchor),
            imgIcon.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            imgIcon.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imgIcon.widthAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 9 / 16),
            
            lblTitle.topAnchor.constraint(equalTo: contentView.topAnchor),
            lblTitle.leadingAnchor.constraint(equalTo: imgIcon.trailingAnchor, constant: 8),
            lblTitle.trailingAnchor.constraint(equalTo: btnMore.leadingAnchor),
            lblTitle.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            btnMore.topAnchor.constraint(equalTo: contentView.topAnchor),
            btnMore.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            btnMore.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func setData(_ data: AccountItemModel) {
        self.imgIcon.image = UIImage(systemName: data.icon)?.withTintColor(UIColor(hexString: "#275DE1")!, renderingMode: .alwaysOriginal)
        self.lblTitle.text = data.title
        self.btnMore.isHidden = !data.isMore
    }
}

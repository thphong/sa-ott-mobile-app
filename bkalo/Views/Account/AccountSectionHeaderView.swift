//
//  AccountSectionHeaderView.swift
//  bkalo
//
//  Created by Nguyen Minh Tam on 18/2/25.
//

import UIKit

final class AccountSectionHeaderView: UITableViewHeaderFooterView {
    
    private var imgAvatar: UIImageView!
    private var stackView: UIStackView!
    private var lblName: UILabel!
    private var lblInfo: UILabel!
    private var btnSwitch: UIButton!
    
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
        
        imgAvatar = UIImageView()
        imgAvatar.contentMode = .scaleAspectFill
        imgAvatar.layer.cornerRadius = imgAvatar.bounds.width / 2
        imgAvatar.clipsToBounds = true
        imgAvatar.layer.masksToBounds = true
        imgAvatar.translatesAutoresizingMaskIntoConstraints = false
        
        lblName = UILabel()
        lblName.font = .interRegular(16)
        lblName.translatesAutoresizingMaskIntoConstraints = false
        
        lblInfo = UILabel()
        lblInfo.font = .interRegular(13)
        lblInfo.textColor = UIColor(hexString: "#727272")
        lblInfo.translatesAutoresizingMaskIntoConstraints = false
        
        stackView = UIStackView(arrangedSubviews: [lblName, lblInfo])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        btnSwitch = UIButton(type: .system)
        btnSwitch.setImage(UIImage(systemName: "arrow.triangle.2.circlepath"), for: .normal)
        btnSwitch.tintColor = UIColor(hexString: "#275DE1")
        btnSwitch.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(imgAvatar)
        contentView.addSubview(stackView)
        contentView.addSubview(btnSwitch)
        
        NSLayoutConstraint.activate([
            imgAvatar.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            imgAvatar.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            imgAvatar.widthAnchor.constraint(equalToConstant: 32),
            imgAvatar.heightAnchor.constraint(equalToConstant: 32),
            
            // stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: imgAvatar.trailingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: btnSwitch.leadingAnchor),
            // stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            btnSwitch.topAnchor.constraint(equalTo: contentView.topAnchor),
            btnSwitch.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            btnSwitch.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            btnSwitch.widthAnchor.constraint(equalTo: contentView.heightAnchor)
        ])
    }
    
    func setData() {
        self.imgAvatar.image = UIImage(systemName: "trophy")
        self.lblName.text = "Tam"
        self.lblInfo.text = "Xem trang cá nhân"
    }
}

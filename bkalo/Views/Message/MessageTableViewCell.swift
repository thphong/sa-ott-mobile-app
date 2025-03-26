//
//  MessageTableViewCell.swift
//  bkalo
//
//  Created by Nguyen Minh Tam on 18/2/25.
//

import UIKit
import SwipeCellKit

final class MessageTableViewCell: SwipeTableViewCell {
    
    private var imgAvatar: UIImageView!
    private var mainStackView: UIStackView!
    private var lblName: UILabel!
    private var lblMessage: UILabel!
    private var lblTime: UILabel!
    private var redUnreadView: UIView!
    private var lblUnreadCount: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureContents()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureContents() {
        imgAvatar = UIImageView()
        imgAvatar.contentMode = .scaleAspectFill
        imgAvatar.layer.cornerRadius = 20
        imgAvatar.clipsToBounds = true
        imgAvatar.layer.masksToBounds = true
        imgAvatar.translatesAutoresizingMaskIntoConstraints = false
        
        lblName = UILabel()
        lblName.font = .interRegular(16)
        lblName.translatesAutoresizingMaskIntoConstraints = false
        
        lblTime = UILabel()
        lblTime.font = .interRegular(12)
        lblTime.textColor = .titanium
        lblTime.translatesAutoresizingMaskIntoConstraints = false
        
        let topSubView = UIView()
        topSubView.translatesAutoresizingMaskIntoConstraints = false
        
        topSubView.addSubview(lblName)
        topSubView.addSubview(lblTime)
        
        lblMessage = UILabel()
        lblMessage.font = .interRegular(14)
        lblMessage.textColor = .titanium
        lblMessage.translatesAutoresizingMaskIntoConstraints = false
        
        lblUnreadCount = UILabel()
        lblUnreadCount.font = .interBold(10)
        lblUnreadCount.textColor = .white
        lblUnreadCount.translatesAutoresizingMaskIntoConstraints = false
        
        redUnreadView = UIView()
        redUnreadView.layer.cornerRadius = 10
        redUnreadView.backgroundColor = .coralRed
        redUnreadView.translatesAutoresizingMaskIntoConstraints = false
        
        redUnreadView.addSubview(lblUnreadCount)
        
        let bottomSubView = UIView()
        bottomSubView.translatesAutoresizingMaskIntoConstraints = false
        
        bottomSubView.addSubview(lblMessage)
        bottomSubView.addSubview(redUnreadView)
        
        mainStackView = UIStackView(arrangedSubviews: [topSubView, bottomSubView])
        mainStackView.axis = .vertical
        mainStackView.distribution = .fillEqually
        mainStackView.spacing = 2
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(imgAvatar)
        contentView.addSubview(mainStackView)
        
        NSLayoutConstraint.activate([
            imgAvatar.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            imgAvatar.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            imgAvatar.widthAnchor.constraint(equalToConstant: 40),
            imgAvatar.heightAnchor.constraint(equalToConstant: 40),
            
            mainStackView.leadingAnchor.constraint(equalTo: imgAvatar.trailingAnchor, constant: 16),
            mainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            mainStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            lblName.topAnchor.constraint(equalTo: topSubView.topAnchor),
            lblName.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor),
            lblName.bottomAnchor.constraint(equalTo: topSubView.bottomAnchor),
            
            lblTime.topAnchor.constraint(equalTo: topSubView.topAnchor),
            lblTime.leadingAnchor.constraint(equalTo: lblName.trailingAnchor, constant: 8),
            lblTime.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor),
            lblTime.bottomAnchor.constraint(equalTo: topSubView.bottomAnchor),
            
            lblUnreadCount.centerXAnchor.constraint(equalTo: redUnreadView.centerXAnchor),
            lblUnreadCount.centerYAnchor.constraint(equalTo: redUnreadView.centerYAnchor),
            
            lblMessage.topAnchor.constraint(equalTo: bottomSubView.topAnchor),
            lblMessage.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor),
            lblMessage.bottomAnchor.constraint(equalTo: bottomSubView.bottomAnchor),
            
            redUnreadView.topAnchor.constraint(equalTo: bottomSubView.topAnchor),
            redUnreadView.leadingAnchor.constraint(equalTo: lblMessage.trailingAnchor, constant: 8),
            redUnreadView.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor),
            redUnreadView.bottomAnchor.constraint(equalTo: bottomSubView.bottomAnchor),
            redUnreadView.widthAnchor.constraint(equalToConstant: 28),
        ])
    }
    
    func setData() {
        self.imgAvatar.image = UIImage(named: "avatar_trump")?.withRenderingMode(.alwaysOriginal)
        self.lblName.text = "Donald Trump"
        self.lblMessage.text = "You are fired !!!"
        self.lblTime.text = "36 phút"
        self.lblUnreadCount.text = "36"
    }
}

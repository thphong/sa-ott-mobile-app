//
//  ContactTableViewCell.swift
//  bkalo
//
//  Created by Nguyen Minh Tam on 19/2/25.
//

import UIKit
import Kingfisher

final class ContactTableViewCell: UITableViewCell {
    
    private var imgAvatar: UIImageView!
    private var lblName: UILabel!
    private var imgPhone: UIImageView!
    private var imgVideo: UIImageView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureContents()
    }
    
    required init?(coder: NSCoder) {
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
        
        imgPhone = UIImageView()
        imgPhone.isHidden = true // MARK: Coming soon
        imgPhone.image = UIImage(systemName: "phone")?.withTintColor(.mediumGray)
        imgPhone.contentMode = .scaleAspectFill
        imgPhone.translatesAutoresizingMaskIntoConstraints = false
        
        imgVideo = UIImageView()
        imgVideo.isHidden = true // MARK: Coming soon
        imgVideo.image = UIImage(systemName: "video")?.withTintColor(.mediumGray)
        imgVideo.contentMode = .scaleAspectFill
        imgVideo.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(imgAvatar)
        contentView.addSubview(lblName)
        contentView.addSubview(imgPhone)
        contentView.addSubview(imgVideo)
        
        NSLayoutConstraint.activate([
            imgAvatar.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            imgAvatar.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            imgAvatar.widthAnchor.constraint(equalToConstant: 40),
            imgAvatar.heightAnchor.constraint(equalToConstant: 40),
            
            lblName.leadingAnchor.constraint(equalTo: imgAvatar.trailingAnchor, constant: 16),
            lblName.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            imgPhone.trailingAnchor.constraint(equalTo: imgVideo.leadingAnchor, constant: -16),
            imgPhone.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            imgPhone.widthAnchor.constraint(equalToConstant: 24),
            imgPhone.heightAnchor.constraint(equalToConstant: 24),
            
            imgVideo.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            imgVideo.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            imgVideo.widthAnchor.constraint(equalToConstant: 24),
            imgVideo.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    func setData(_ data: ChatPartner) {
        if let url = data.fullAvatarURL, let avatarURL = data.avatarURL, !avatarURL.isEmpty {
            self.imgAvatar.kf.setImage(with: url)
        } else {
            self.imgAvatar.image = UIImage(systemName: "person.circle.fill")
        }
        self.lblName.text = data.name
    }
}

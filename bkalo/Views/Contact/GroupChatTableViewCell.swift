//
//  GroupChatTableViewCell.swift
//  bkalo
//
//  Created by Nguyen Minh Tam on 16/4/25.
//

import UIKit

final class GroupChatTableViewCell: UITableViewCell {

    private var avatarView: UIImageView!
    private var nameLabel: UILabel!
    private var memberCountLabel: UILabel!
    private var typeIconView: UIImageView!
    private var textStackView: UIStackView!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureContents()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureContents() {
        avatarView = UIImageView()
        avatarView.translatesAutoresizingMaskIntoConstraints = false
        avatarView.layer.cornerRadius = 28
        avatarView.clipsToBounds = true
        avatarView.contentMode = .scaleAspectFill
        avatarView.backgroundColor = .lightGray

        nameLabel = UILabel()
        nameLabel.font = .interBold(16)

        memberCountLabel = UILabel()
        memberCountLabel.font = .interRegular(13)
        memberCountLabel.textColor = .gray

        textStackView = UIStackView(arrangedSubviews: [nameLabel, memberCountLabel])
        textStackView.axis = .vertical
        textStackView.spacing = 4
        textStackView.alignment = .leading
        textStackView.translatesAutoresizingMaskIntoConstraints = false

        typeIconView = UIImageView()
        typeIconView.translatesAutoresizingMaskIntoConstraints = false
        typeIconView.tintColor = .gray
        typeIconView.contentMode = .scaleAspectFit

        contentView.addSubview(avatarView)
        contentView.addSubview(textStackView)
        contentView.addSubview(typeIconView)

        NSLayoutConstraint.activate([
            avatarView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            avatarView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            avatarView.widthAnchor.constraint(equalToConstant: 56),
            avatarView.heightAnchor.constraint(equalToConstant: 56),

            textStackView.leadingAnchor.constraint(equalTo: avatarView.trailingAnchor, constant: 12),
            textStackView.centerYAnchor.constraint(equalTo: avatarView.centerYAnchor),
            textStackView.trailingAnchor.constraint(lessThanOrEqualTo: typeIconView.leadingAnchor, constant: -8),

            typeIconView.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor),
            typeIconView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            typeIconView.widthAnchor.constraint(equalToConstant: 20),
            typeIconView.heightAnchor.constraint(equalToConstant: 20)
        ])
    }

    func setData(_ group: GroupChat) {
        nameLabel.text = group.name
        memberCountLabel.text = "\(group.memberCount) members"

        if let urlStr = group.avatarURL, let url = URL(string: urlStr) {
            // Replace with Kingfisher or SDWebImage call
            // avatarView.kf.setImage(with: url)
            avatarView.image = UIImage(systemName: "person.3.fill") // Placeholder
        } else {
            avatarView.image = UIImage(systemName: "person.3.fill")
        }

        if group.type.lowercased() == "private" {
            typeIconView.image = UIImage(systemName: "lock.fill")
        } else {
            typeIconView.image = UIImage(systemName: "globe")
        }
    }
}



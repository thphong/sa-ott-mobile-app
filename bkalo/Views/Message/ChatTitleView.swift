//
//  ChatTitleView.swift
//  bkalo
//
//  Created by Nguyen Minh Tam on 15/4/25.
//

import UIKit

final class ChatTitleView: UIView {
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .interMedium(16)
        label.textColor = .white
        return label
    }()
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 2
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    private func setupViews() {
        addSubview(stackView)
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(statusLabel)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    func configure(name: String, isOnline: Bool, lastSeen: Date?) {
        nameLabel.text = name
        
        if isOnline {
            statusLabel.text = "Online"
            statusLabel.textColor = .white
        } else {
            statusLabel.isHidden = true
        }
    }
}

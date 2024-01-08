//
//  SubcateCollectionViewCell.swift
//  vnlook
//
//  Created by Nguyễn Minh Tâm on 08/01/2024.
//

import UIKit

final class SubcateCollectionViewCell: UICollectionViewCell {
    private var subView: UIView!
    private var imgView: UIImageView!
    private var lblTitle: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureContents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureContents() {
        subView = UIView()
        subView.backgroundColor = UIColor(hexString: "#04555C")
        subView.layer.cornerRadius = 10
        subView.translatesAutoresizingMaskIntoConstraints = false
        
        imgView = UIImageView()
        imgView.image = UIImage(systemName: "person.circle")
        imgView.tintColor = .yellow
        imgView.layer.cornerRadius = 50
        imgView.translatesAutoresizingMaskIntoConstraints = false
        
        lblTitle = UILabel()
        lblTitle.text = "South"
        lblTitle.font = UIFont.interRegular(14)
        lblTitle.textColor = .yellow
        lblTitle.translatesAutoresizingMaskIntoConstraints = false
        
        subView.addSubview(imgView)
        subView.addSubview(lblTitle)
        contentView.addSubview(subView)
        
        NSLayoutConstraint.activate([
            subView.topAnchor.constraint(equalTo: contentView.topAnchor),
            subView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            subView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            subView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            imgView.topAnchor.constraint(equalTo: subView.topAnchor),
            imgView.leadingAnchor.constraint(equalTo: subView.leadingAnchor, constant: 8),
            imgView.bottomAnchor.constraint(equalTo: subView.bottomAnchor),
            imgView.widthAnchor.constraint(equalTo: imgView.heightAnchor),
            
            lblTitle.topAnchor.constraint(equalTo: subView.topAnchor),
            lblTitle.leadingAnchor.constraint(equalTo: imgView.trailingAnchor, constant: 8),
            lblTitle.trailingAnchor.constraint(equalTo: subView.trailingAnchor, constant: -8),
            lblTitle.bottomAnchor.constraint(equalTo: subView.bottomAnchor)
        ])
    }
}

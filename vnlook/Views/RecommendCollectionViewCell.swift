//
//  RecommendCollectionViewCell.swift
//  vnlook
//
//  Created by Nguyễn Minh Tâm on 08/01/2024.
//

import UIKit

final class RecommendCollectionViewCell: UICollectionViewCell {
    private var imgView: UIImageView!
    private var locView: UIImageView!
    private var ratingView: UIImageView!
    private var lblTitle: UILabel!
    private var lblLocation: UILabel!
    private var lblRating: UILabel!
    private var lblDesc: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureContents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureContents() {
        imgView = UIImageView()
        imgView.image = UIImage(named: "testing")?.withRenderingMode(.alwaysOriginal)
        imgView.layer.masksToBounds = true
        imgView.layer.cornerRadius = 20
        imgView.translatesAutoresizingMaskIntoConstraints = false
        
        lblTitle = UILabel()
        lblTitle.text = "Dragon Bridge"
        lblTitle.font = .interBold(14)
        lblTitle.textColor = .yellow
        lblTitle.translatesAutoresizingMaskIntoConstraints = false
        
        locView = UIImageView()
        locView.image = UIImage(named: "ic_location")?.withRenderingMode(.alwaysOriginal)
        locView.tintColor = .white
        locView.translatesAutoresizingMaskIntoConstraints = false
        
        lblLocation = UILabel()
        lblLocation.text = "Da Nang"
        lblLocation.font = .interMedium(12)
        lblLocation.textColor = UIColor(hexString: "#F2EBBC")
        lblLocation.translatesAutoresizingMaskIntoConstraints = false
        
        ratingView = UIImageView()
        ratingView.image = UIImage(systemName: "star.fill")
        ratingView.tintColor = .yellow
        ratingView.translatesAutoresizingMaskIntoConstraints = false
        
        lblRating = UILabel()
        lblRating.text = "4.5"
        lblRating.font = .interMedium(12)
        lblRating.textColor = UIColor(hexString: "#F2EBBC")
        lblRating.translatesAutoresizingMaskIntoConstraints = false
        
        lblDesc = UILabel()
        lblDesc.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi egestas et nunc eget elementum. Nunc eros metus, suscipit quis lorem eget, interdum pellentesque elit. Nulla nisi justo, fringilla non congue ut, hendrerit a arcu. Maecenas interdum eros lectus"
        lblDesc.font = .interMedium(12)
        lblDesc.textColor = UIColor(hexString: "#F2EBBC")
        lblDesc.numberOfLines = 3
        lblDesc.translatesAutoresizingMaskIntoConstraints = false
        
        let subStackView1 = UIStackView(arrangedSubviews: [locView, lblLocation])
        subStackView1.axis = .horizontal
        subStackView1.translatesAutoresizingMaskIntoConstraints = false
        
        let subStackView2 = UIStackView(arrangedSubviews: [ratingView, lblRating])
        subStackView2.axis = .horizontal
        subStackView2.translatesAutoresizingMaskIntoConstraints = false
        
        imgView.addSubview(lblTitle)
        imgView.addSubview(subStackView1)
        imgView.addSubview(subStackView2)
        imgView.addSubview(lblDesc)
        contentView.addSubview(imgView)
        
        NSLayoutConstraint.activate([
            imgView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imgView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imgView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imgView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            lblTitle.topAnchor.constraint(equalTo: imgView.topAnchor, constant: 8),
            lblTitle.leadingAnchor.constraint(equalTo: imgView.leadingAnchor, constant: 12),
            
            subStackView1.topAnchor.constraint(equalTo: lblTitle.bottomAnchor, constant: 8),
            subStackView1.leadingAnchor.constraint(equalTo: imgView.leadingAnchor, constant: 8),
            
            subStackView2.topAnchor.constraint(equalTo: lblTitle.bottomAnchor, constant: 8),
            subStackView2.leadingAnchor.constraint(equalTo: subStackView1.trailingAnchor, constant: 8),
            
            lblDesc.leadingAnchor.constraint(equalTo: imgView.leadingAnchor, constant: 12),
            lblDesc.trailingAnchor.constraint(equalTo: imgView.trailingAnchor, constant: -12),
            lblDesc.bottomAnchor.constraint(equalTo: imgView.bottomAnchor, constant: -8)
        ])
    }
}


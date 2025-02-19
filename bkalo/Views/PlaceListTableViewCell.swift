//
//  PlaceListTableViewCell.swift
//  bkalo
//
//  Created by Nguyễn Minh Tâm on 11/01/2024.
//

import UIKit

protocol PlaceListTableViewCellDelegate {
    func onDataSelected(_ data: PlaceModel)
}

final class PlaceListTableViewCell: UITableViewCell {
    private var mainView: UIView!
    private var imgView: UIImageView!
    private var stackView: UIStackView!
    private var lblTitle: UILabel!
    private var lblDestination: UILabel!
    private var lblPrice: UILabel!
    private var btnView: UIButton!
    private var placeModel: PlaceModel!
    
    var delegate: PlaceListTableViewCellDelegate?
    
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
        
        mainView = UIView()
        mainView.layer.borderWidth = 2
        mainView.layer.borderColor = UIColor(hexString: "#D99962")!.cgColor
        mainView.translatesAutoresizingMaskIntoConstraints = false
        
        imgView = UIImageView()
        imgView.image = UIImage(named: "testing")?.withRenderingMode(.alwaysOriginal)
        imgView.contentMode = .scaleAspectFill
        imgView.layer.masksToBounds = true
        imgView.layer.cornerRadius = 20
        imgView.translatesAutoresizingMaskIntoConstraints = false
        
        lblTitle = UILabel()
        lblTitle.font = .interMedium(16)
        lblTitle.textColor = UIColor(hexString: "#F2EBDC")
        lblTitle.numberOfLines = 2
        lblTitle.translatesAutoresizingMaskIntoConstraints = false
        
        lblDestination = UILabel()
        lblDestination.font = .interRegular(13)
        lblDestination.textColor = UIColor(hexString: "#F2EBDC")
        lblDestination.translatesAutoresizingMaskIntoConstraints = false
        
        lblPrice = UILabel()
        lblPrice.font = .interMedium(16)
        lblPrice.textColor = UIColor(hexString: "#F2EBDC")
        lblPrice.translatesAutoresizingMaskIntoConstraints = false
        
        stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        let title = "VIEW"
        let attrs = [NSAttributedString.Key.font: UIFont.interBold(16), NSAttributedString.Key.foregroundColor: UIColor(hexString: "#F2EBDC")]
        let normalString = NSMutableAttributedString(string: title, attributes: attrs as [NSAttributedString.Key : Any])
        
        btnView = UIButton(type: .system)
        btnView.backgroundColor = UIColor(hexString: "#027368")
        btnView.setAttributedTitle(normalString, for: .normal)
        btnView.layer.cornerRadius = 10
        btnView.translatesAutoresizingMaskIntoConstraints = false
        btnView.addTarget(self, action: #selector(actionView), for: .touchUpInside)
        
        stackView.addArrangedSubview(lblTitle)
        stackView.addArrangedSubview(lblDestination)
        stackView.addArrangedSubview(lblPrice)
        mainView.addSubview(imgView)
        mainView.addSubview(stackView)
        mainView.addSubview(btnView)
        contentView.addSubview(mainView)
        
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            mainView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            mainView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            mainView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            imgView.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 8),
            imgView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 8),
            imgView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -8),
            imgView.heightAnchor.constraint(equalToConstant: 64),
            imgView.widthAnchor.constraint(equalTo: imgView.heightAnchor),
            
            stackView.topAnchor.constraint(equalTo: mainView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: imgView.trailingAnchor, constant: 8),
            stackView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor),
            
            btnView.centerYAnchor.constraint(equalTo: mainView.centerYAnchor),
            btnView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -8),
            btnView.heightAnchor.constraint(equalToConstant: 32),
            btnView.widthAnchor.constraint(equalTo: btnView.heightAnchor, multiplier: 5 / 2)
        ])
    }
    
    func setData(_ data: PlaceModel) {
        placeModel = data
        lblTitle.text = data.name
        lblDestination.text = data.location
        lblPrice.text = String(data.price)
    }
    
    @objc func actionView() {
        self.delegate?.onDataSelected(placeModel)
    }
}

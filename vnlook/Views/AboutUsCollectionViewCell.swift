//
//  AboutUsCollectionViewCell.swift
//  vnlook
//
//  Created by Nguyen Minh Tam on 11/01/2024.
//

import UIKit
import Cards

protocol AboutUsCollectionViewCellDelegate {
    func onDataSelected(_ card: CardHighlight)
}

final class AboutUsCollectionViewCell: UICollectionViewCell {
    private var card: CardHighlight!
    var delegate: AboutUsCollectionViewCellDelegate?
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                print("Shiet !")
                delegate?.onDataSelected(card)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureContents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureContents() {
        card = CardHighlight()
        card.backgroundColor = UIColor(hexString: "#027368")
        card.icon = UIImage(named: "testing")?.withRenderingMode(.alwaysOriginal)
        card.title = "Tam Nguyen"
        card.itemTitle = "Tech Dev"
        card.itemSubtitle = "HCMUT"
        card.textColor = UIColor(hexString: "#F2EBDC")!
        card.buttonText = "View"
        card.hasParallax = true
        card.translatesAutoresizingMaskIntoConstraints = false
        card.isUserInteractionEnabled = false
        
        contentView.addSubview(card)
        
        NSLayoutConstraint.activate([
            card.topAnchor.constraint(equalTo: contentView.topAnchor),
            card.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            card.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            card.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func setData() {
        
    }
}

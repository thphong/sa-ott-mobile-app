//
//  AboutUsCollectionViewCell.swift
//  bkalo
//
//  Created by Nguyen Minh Tam on 11/01/2024.
//

import UIKit
import Cards

final class AboutUsCollectionViewCell: UICollectionViewCell {
    private var card: CardHighlight!
    private var authorModel: AuthorModel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureContents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureContents() {
        card = CardHighlight()
        card.delegate = self
        card.backgroundColor = UIColor(hexString: "#027368")
        card.textColor = UIColor(hexString: "#F2EBDC")!
        card.buttonText = "View"
        card.hasParallax = true
        card.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(card)
        
        NSLayoutConstraint.activate([
            card.topAnchor.constraint(equalTo: contentView.topAnchor),
            card.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            card.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            card.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func setData(_ data: AuthorModel) {
        authorModel = data
        card.icon = UIImage(named: "testing")?.withRenderingMode(.alwaysOriginal)
        card.title = data.name
        card.itemTitle = data.role
        card.itemSubtitle = data.school
    }
}

extension AboutUsCollectionViewCell: CardDelegate {
    func cardDidTapInside(card: Card) {
        if let myViewController = parentViewController as? AboutUsViewController {
            let vc = CardContentViewController(authorModel)
            card.shouldPresent(vc, from: myViewController, fullscreen: false)
        }
        
    }
    
    func cardHighlightDidTapButton(card: CardHighlight, button: UIButton) {
    }
}

//
//  CategoryMenuCell.swift
//  bkalo
//
//  Created by Nguyen Minh Tam on 19/2/25.
//

import UIKit
import PagingKit

final class CategoryMenuCell: PagingMenuViewCell {
    
    private var lblTitle: UILabel!
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                lblTitle.textColor = .black
                lblTitle.font = .interMedium(16)
            } else {
                lblTitle.textColor = .black.withAlphaComponent(0.6)
                lblTitle.font = .interMedium(14)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureContents()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureContents()
    }
    
    private func configureContents() {
        lblTitle = UILabel()
        lblTitle.textColor = .white
        lblTitle.font = .interMedium(14)
        lblTitle.textAlignment = .center
        lblTitle.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(lblTitle)
        
        NSLayoutConstraint.activate([
            lblTitle.topAnchor.constraint(equalTo: topAnchor),
            lblTitle.leadingAnchor.constraint(equalTo: leadingAnchor),
            lblTitle.trailingAnchor.constraint(equalTo: trailingAnchor),
            lblTitle.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func setData(_ data: String) {
        lblTitle.text = data
    }
}

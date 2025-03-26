//
//  NotificationDialogView.swift
//  bkalo
//
//  Created by Nguyen Minh Tam on 23/3/25.
//

import UIKit

final class NotificationDialogView: UIView {
    
    private var subView: UIView!
    private var imgView: UIImageView!
    private var lblDesc: UILabel!
    var onDismiss: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureContents()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureContents()
    }
    
    private func configureContents() {
        Timer.scheduledTimer(withTimeInterval: 5, repeats: false) { _ in
            UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseIn, animations: {
                self.alpha = 0
                self.subView.transform = CGAffineTransform(translationX: 0, y: UIScreen.main.bounds.height)
            }) { _ in
                self.removeFromSuperview()
                self.onDismiss?()
            }
        }
        
        subView = UIView()
        subView.backgroundColor = .nearWhite
        subView.layer.cornerRadius = 10
        subView.layer.borderColor = UIColor.lightGray.cgColor
        subView.layer.borderWidth = 1
        subView.translatesAutoresizingMaskIntoConstraints = false
        
        imgView = UIImageView()
        imgView.image = UIImage(systemName: "checkmark.circle")
        imgView.contentMode = .scaleAspectFill
        imgView.tintColor = .green
        imgView.translatesAutoresizingMaskIntoConstraints = false
        
        lblDesc = UILabel()
        lblDesc.text = "Xác nhận thành công"
        lblDesc.font = .interRegular(16)
        lblDesc.textAlignment = .center
        lblDesc.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(subView)
        subView.addSubview(imgView)
        subView.addSubview(lblDesc)
        
        NSLayoutConstraint.activate([
            subView.centerXAnchor.constraint(equalTo: centerXAnchor),
            subView.centerYAnchor.constraint(equalTo: centerYAnchor),
            subView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.6),
            subView.heightAnchor.constraint(equalTo: subView.widthAnchor, multiplier: 9 / 16),
            
            imgView.topAnchor.constraint(equalTo: subView.topAnchor, constant: 16),
            imgView.centerXAnchor.constraint(equalTo: subView.centerXAnchor),
            imgView.heightAnchor.constraint(equalToConstant: 64),
            imgView.widthAnchor.constraint(equalToConstant: 64),
            
            lblDesc.topAnchor.constraint(equalTo: imgView.bottomAnchor, constant: 16),
            lblDesc.leadingAnchor.constraint(equalTo: subView.leadingAnchor, constant: 16),
            lblDesc.trailingAnchor.constraint(equalTo: subView.trailingAnchor, constant: -16),
            lblDesc.centerXAnchor.constraint(equalTo: subView.centerXAnchor)
        ])
    }
}

//
//  DetailViewController.swift
//  vnlook
//
//  Created by Nguyễn Minh Tâm on 10/01/2024.
//

import UIKit

final class DetailViewController: UIViewController {
    private var imgView: UIImageView!
    private var subView: UIView!
    private var locView: UIImageView!
    private var likeView: UIImageView!
    private var lblTitle: UILabel!
    private var lblLocation: UILabel!
    private var lblSubtitle: UILabel!
    private var lblDesc: UILabel!
    
    override func loadView() {
        super.loadView()
        
        imgView = UIImageView()
        imgView.image = UIImage(named: "testing")?.withRenderingMode(.alwaysOriginal)
        imgView.translatesAutoresizingMaskIntoConstraints = false
        
        subView = UIView()
        subView.backgroundColor = .white
        subView.layer.cornerRadius = 20
        subView.translatesAutoresizingMaskIntoConstraints = false
        
        lblTitle = UILabel()
        lblTitle.text = "Dragon Bridge"
        lblTitle.font = .interBold(24)
        lblTitle.textColor = UIColor(hexString: "#F2EBBC")
        lblTitle.translatesAutoresizingMaskIntoConstraints = false
        
        locView = UIImageView()
        locView.image = UIImage(systemName: "mappin")
        locView.tintColor = UIColor(hexString: "#025959")
        locView.translatesAutoresizingMaskIntoConstraints = false
        
        likeView = UIImageView()
        likeView.image = UIImage(systemName: "heart.fill")?.scalePreservingAspectRatio(targetSize: CGSize(width: 48, height: 48)).withTintColor(UIColor.red)
        likeView.backgroundColor = .white
        likeView.translatesAutoresizingMaskIntoConstraints = false
        
        lblLocation = UILabel()
        lblLocation.text = "Da Nang"
        lblLocation.font = .interMedium(18)
        lblLocation.textColor = UIColor(hexString: "#025959")
        lblLocation.translatesAutoresizingMaskIntoConstraints = false
        
        let subStackView1 = UIStackView(arrangedSubviews: [locView, lblLocation])
        subStackView1.axis = .horizontal
        subStackView1.translatesAutoresizingMaskIntoConstraints = false
        
        lblSubtitle = UILabel()
        lblSubtitle.text = "About the trip"
        lblSubtitle.font = .interBold(20)
        lblSubtitle.textColor = UIColor(hexString: "#D99962")
        lblSubtitle.translatesAutoresizingMaskIntoConstraints = false
        
        lblDesc = UILabel()
        lblDesc.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi egestas et nunc eget elementum. Nunc eros metus, suscipit quis lorem eget, interdum pellentesque elit. Nulla nisi justo, fringilla non congue ut, hendrerit a arcu. Maecenas interdum eros lectus"
        lblDesc.font = .interRegular(12)
        lblDesc.textColor = UIColor(hexString: "#D99962")
        lblDesc.numberOfLines = 0
        lblDesc.translatesAutoresizingMaskIntoConstraints = false
        
        subView.addSubview(subStackView1)
        subView.addSubview(lblSubtitle)
        subView.addSubview(lblDesc)
        view.addSubview(imgView)
        view.addSubview(subView)
        view.addSubview(lblTitle)
        view.addSubview(likeView)
        
        NSLayoutConstraint.activate([
            imgView.topAnchor.constraint(equalTo: view.topAnchor),
            imgView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imgView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imgView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 2 / 3),
            
            subView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            subView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            subView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            subView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1 / 2),
            
            likeView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            likeView.centerYAnchor.constraint(equalTo: subView.topAnchor),
            
            lblTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            lblTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            lblTitle.bottomAnchor.constraint(equalTo: subView.topAnchor, constant: -8),
            
            subStackView1.topAnchor.constraint(equalTo: subView.topAnchor, constant: 16),
            subStackView1.leadingAnchor.constraint(equalTo: subView.leadingAnchor, constant: 13),
            
            lblSubtitle.topAnchor.constraint(equalTo: subStackView1.bottomAnchor, constant: 16),
            lblSubtitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
             
            lblDesc.topAnchor.constraint(equalTo: lblSubtitle.bottomAnchor, constant: 8),
            lblDesc.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            lblDesc.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        likeView.layer.cornerRadius = likeView.bounds.height / 2
    }
}

//
//  ProfileViewController.swift
//  vnlook
//
//  Created by Nguyễn Minh Tâm on 09/01/2024.
//

import UIKit

class ProfileViewController: UIViewController {
    private var imgView: UIImageView!
    private var subView: UIView!
    private var locView: UIImageView!
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
        lblTitle.textColor = .white
        lblTitle.translatesAutoresizingMaskIntoConstraints = false
        
        locView = UIImageView()
        locView.image = UIImage(systemName: "mappin")
        locView.tintColor = UIColor(hexString: "#04555C")
        locView.translatesAutoresizingMaskIntoConstraints = false
        
        lblLocation = UILabel()
        lblLocation.text = "Da Nang"
        lblLocation.font = .interMedium(18)
        lblLocation.textColor = UIColor(hexString: "#04555C")
        lblLocation.translatesAutoresizingMaskIntoConstraints = false
        
        let subStackView1 = UIStackView(arrangedSubviews: [locView, lblLocation])
        subStackView1.axis = .horizontal
        subStackView1.translatesAutoresizingMaskIntoConstraints = false
        
        lblSubtitle = UILabel()
        lblSubtitle.text = "About the trip"
        lblSubtitle.font = .interBold(20)
        lblSubtitle.textColor = UIColor(hexString: "#7D7D7D")
        lblSubtitle.translatesAutoresizingMaskIntoConstraints = false
        
        lblDesc = UILabel()
        lblDesc.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi egestas et nunc eget elementum. Nunc eros metus, suscipit quis lorem eget, interdum pellentesque elit. Nulla nisi justo, fringilla non congue ut, hendrerit a arcu. Maecenas interdum eros lectus"
        lblDesc.font = .interRegular(12)
        lblDesc.textColor = UIColor(hexString: "#7D7D7D")
        lblDesc.numberOfLines = 0
        lblDesc.translatesAutoresizingMaskIntoConstraints = false
        
        subView.addSubview(subStackView1)
        subView.addSubview(lblSubtitle)
        subView.addSubview(lblDesc)
        view.addSubview(imgView)
        view.addSubview(subView)
        view.addSubview(lblTitle)
        
        NSLayoutConstraint.activate([
            imgView.topAnchor.constraint(equalTo: view.topAnchor),
            imgView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imgView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imgView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 2 / 3),
            
            subView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            subView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            subView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            subView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1 / 2),
            
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

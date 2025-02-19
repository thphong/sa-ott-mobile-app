//
//  AboutUsViewController.swift
//  bkalo
//
//  Created by Nguyễn Minh Tâm on 11/01/2024.
//

import UIKit
import Cards

final class AboutUsViewController: UIViewController {
    private var collectionView: UICollectionView!
    private var mockDatas: [AuthorModel] = [
        AuthorModel(),
        AuthorModel(),
        AuthorModel(),
        AuthorModel()
    ]
    
    override func loadView() {
        super.loadView()
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumInteritemSpacing = 16
        flowLayout.minimumLineSpacing = 16
        flowLayout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 0, right: 16)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.alwaysBounceHorizontal = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(AboutUsCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: AboutUsCollectionViewCell.self))
        
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(hexString: "#5DA6A6")
        navigationItem.title = "About Us"
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes as [NSAttributedString.Key : Any]
    }

}

extension AboutUsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let layout = collectionViewLayout as? UICollectionViewFlowLayout else { return .zero }
        
        let width: CGFloat = itemWidth(collectionView: collectionView, layout: layout, column: 2, columnIPad: 4, additionalColumn: 0)
        let height: CGFloat = width 
        return CGSize(width: width, height: height)
    }
}

extension AboutUsViewController: UICollectionViewDelegate {
    
}

extension AboutUsViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mockDatas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: AboutUsCollectionViewCell.self), for: indexPath) as! AboutUsCollectionViewCell
        cell.setData(mockDatas[indexPath.item])
        return cell
    }
}

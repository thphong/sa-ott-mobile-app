//
//  RecommendTableViewCell.swift
//  vnlook
//
//  Created by Nguyễn Minh Tâm on 08/01/2024.
//

import UIKit

final class RecommendTableViewCell: CategoryTableViewCell {
    private var collectionView: UICollectionView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureContents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureContents() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 16
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(RecommendCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: RecommendCollectionViewCell.self))
        
        subContentView.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: subContentView.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: subContentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: subContentView.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: subContentView.bottomAnchor),
            collectionView.heightAnchor.constraint(equalTo: subContentView.widthAnchor, multiplier: 9 / 20)
        ])
    }

}

extension RecommendTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.bounds.height
        let width = height * 2
        return CGSize(width: width, height: height)
    }
}

extension RecommendTableViewCell: UICollectionViewDelegate {}

extension RecommendTableViewCell: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: RecommendCollectionViewCell.self), for: indexPath)
        return cell
    }
}

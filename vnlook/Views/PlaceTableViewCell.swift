//
//  PlaceTableViewCell.swift
//  vnlook
//
//  Created by Nguyễn Minh Tâm on 08/01/2024.
//

import UIKit

final class PlaceTableViewCell: CategoryTableViewCell {
    private var collectionView: UICollectionView!
    private var mockData: PlaceModel!
    
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
        collectionView.register(PlaceCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: PlaceCollectionViewCell.self))
        
        subContentView.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: subContentView.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: subContentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: subContentView.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: subContentView.bottomAnchor),
            collectionView.heightAnchor.constraint(equalTo: subContentView.widthAnchor, multiplier: 9 / 20)
        ])
    }
    
    func setData(_ data: PlaceModel) {
        mockData = data
    }
}

extension PlaceTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.bounds.height
        let width = height - 16
        return CGSize(width: width, height: height)
    }
}

extension PlaceTableViewCell: UICollectionViewDelegate {
    
}

extension PlaceTableViewCell: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: PlaceCollectionViewCell.self), for: indexPath) as! PlaceCollectionViewCell
        cell.setData(mockData)
        return cell
    }
}

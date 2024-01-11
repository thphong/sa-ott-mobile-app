//
//  SubcateTableViewCell.swift
//  vnlook
//
//  Created by Nguyễn Minh Tâm on 08/01/2024.
//

import UIKit

protocol SubcateTableViewCellDelegate {
    func onDataSelected()
}

final class SubcateTableViewCell: CategoryTableViewCell {
    private var collectionView: UICollectionView!
    
    var delegate: SubcateTableViewCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureContents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureContents() {
        selectionStyle = .none
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 16
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(SubcateCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: SubcateCollectionViewCell.self))
        
        subContentView.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: subContentView.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: subContentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: subContentView.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: subContentView.bottomAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 36)
        ])
    }
}

extension SubcateTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.bounds.height
        let width = height * 3
        return CGSize(width: width, height: height)
    }
}

extension SubcateTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.onDataSelected()
    }
}

extension SubcateTableViewCell: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: SubcateCollectionViewCell.self), for: indexPath)
        return cell
    }
}

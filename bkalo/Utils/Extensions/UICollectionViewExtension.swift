//
//  UICollectionViewExtension.swift
//  bkalo
//
//  Created by Nguyen Minh Tam on 11/01/2024.
//

import UIKit

extension UICollectionViewDelegateFlowLayout {
    func itemWidth(collectionView: UICollectionView, layout: UICollectionViewFlowLayout, column: Int, columnIPad: Int, additionalColumn: Int = 1) -> CGFloat {
        guard column > 0 else { return 0 }
        
        let columns = numberOfColumns(column, columnIPad: columnIPad, additionalColumn: additionalColumn)
        let horizontalSpacing = CGFloat(max(columns - 1, 0)) * layout.minimumInteritemSpacing
        let horizontalInset = layout.sectionInset.left + layout.sectionInset.right
        let width = (collectionView.bounds.width - horizontalSpacing - horizontalInset) / CGFloat(columns)
        return width.rounded(.down)
    }
    
    private func numberOfColumns(_ column: Int, columnIPad: Int, additionalColumn: Int) -> Int {
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            return UIWindow.isLandscape ? columnIPad + additionalColumn : columnIPad
        default:
            return column
        }
    }
}

//
//  UICollectionView+Extension.swift
//  pinCodeScreen
//
//  Created by michail on 12.06.2023.
//

import UIKit

extension UICollectionView {
    
    func registerCell(ofType type: UICollectionViewCell.Type) {
        register(UINib(nibName: type.className, bundle: nil), forCellWithReuseIdentifier: type.className)
    }
    
    func dequeueCell<T>(ofType type: T.Type, index: IndexPath) -> T? where T: UICollectionViewCell {
        dequeueReusableCell(withReuseIdentifier: T.className, for: index) as? T
    }
    
    func registerHeadeView(ofType type: UICollectionReusableView.Type) {
        register(UINib(nibName: type.className, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: type.className)
    }
    
    func dequeueHeaderView<T>(ofType type: T.Type, index: IndexPath) -> T? where T: UICollectionReusableView {
        dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: T.className, for: index) as? T
    }
}

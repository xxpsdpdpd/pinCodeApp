//
//  NumberPadView.swift
//  pinCodeScreen
//
//  Created by michail on 12.06.2023.
//

import UIKit

enum ButtonsConfig {
    case number
    case delete
}

protocol NumberPadViewDelegate: AnyObject {
    func selectedItem(index: Int)
    func remove()
}

protocol PNumberPadView {
    func disableKeyboard()
    func enableKeyboard()
}

final class NumberPadView: UIView, NibLoadable {

    @IBOutlet private weak var collectionView: UICollectionView!
    
    private let numberOfItems: Int = 12
    
    weak var delegate: NumberPadViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        setupFromNib()
        setupCollectionView()
        self.backgroundColor = .blue
    }
    
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isScrollEnabled = false
        collectionView.registerCell(ofType: NumberPadCell.self)
    }
}

extension NumberPadView: PNumberPadView {
    func disableKeyboard() {
        self.collectionView.isUserInteractionEnabled = false
        self.collectionView.alpha = 0.5
    }
    
    func enableKeyboard() {
        self.collectionView.isUserInteractionEnabled = true
        self.collectionView.alpha = 1.0
    }
}

extension NumberPadView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? NumberPadCell else {
            return
        }
        
        cell.alpha = 0.5
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            cell.alpha = 1
        }
        if cell.type == .action {
            delegate?.remove()
        } else {
            delegate?.selectedItem(index: indexPath.row > 9 ? 0 : indexPath.row)
        }
    }
}

extension NumberPadView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let noOfCellsInRow = 3

        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout

        let totalSpace = flowLayout.sectionInset.left + flowLayout.sectionInset.right + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))

        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))

        return CGSize(width: size, height: size)
    }
}

extension NumberPadView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueCell(ofType: NumberPadCell.self, index: indexPath) else {
            return UICollectionViewCell()
        }
        
        let type: TypeOfCell = (indexPath.row == 11 || indexPath.row == 9) ? .action : .numeric
        var model = NumberPadCellModel(title: "\(indexPath.row + 1)", type: type)
        
        if indexPath.row == 9 {
            cell.isHidden = true
        } else {
            if indexPath.row == 10 {
                model.title = "0"
            }
            cell.configureViewWith(model: model)
        }
        return cell
    }
}

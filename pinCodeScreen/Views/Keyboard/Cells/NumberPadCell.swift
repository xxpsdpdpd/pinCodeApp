//
//  NumberPadCell.swift
//  pinCodeScreen
//
//  Created by michail on 12.06.2023.
//

import UIKit

typealias NoParamClosure = () -> ()

enum TypeOfCell {
    case numeric
    case action
}

protocol TransferDataCollectionView {
    associatedtype InputData
    
    func configureViewWith(model: InputData)
}

final class NumberPadCell: UICollectionViewCell {
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    
    private(set) var type: TypeOfCell? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.borderWidth = 0.5
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 10
        self.layer.borderColor = UIColor.gray.cgColor
        self.backgroundColor = .orange
    }
}

extension NumberPadCell: TransferDataCollectionView {
    typealias InputData = NumberPadCellModel
    
    func configureViewWith(model: InputData) {
        titleLabel.text = model.title
        type = model.type
        imageView.isHidden = type == .numeric
        titleLabel.isHidden = type == .action
    }
}

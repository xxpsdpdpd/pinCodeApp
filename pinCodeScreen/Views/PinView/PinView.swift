//
//  PinView.swift
//  pinCodeScreen
//
//  Created by michail on 12.06.2023.
//

import UIKit

protocol PPinView {
    func configureDot(_ index: Int, type: PinViewConfig)
    func resetDots()
    func invalidPassword()
    func validPassword()
}

enum PinViewConfig {
    case remove
    case append
}

final class PinView: UIView, NibLoadable {
    @IBOutlet private weak var errorLabel: UILabel!
    @IBOutlet private var views: [UIView]!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupFromNib()
        errorLabel.alpha = 0
        views.forEach {
            $0.layer.masksToBounds = true
            $0.layer.cornerRadius = $0.bounds.width / 2
            $0.layer.borderWidth = 0.5
            $0.layer.borderColor = UIColor.black.cgColor
        }
    }
    
    private func animateErrorLabel(needToHide: Bool) {
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.errorLabel.alpha = needToHide ? 0 : 1
        }
    }
}

extension PinView: PPinView {
    func configureDot(_ index: Int, type: PinViewConfig) {
        views[index].backgroundColor = type == .append ? .black : .clear
    }
    
    func resetDots() {
        animateErrorLabel(needToHide: true)
        views.forEach { $0.backgroundColor = .clear }
    }
    
    func invalidPassword() {
        passwordAction(false)
        animateErrorLabel(needToHide: false)
    }
    
    func validPassword() {
        animateErrorLabel(needToHide: true)
        passwordAction(true)
    }
    
    private func passwordAction(_ isValid: Bool) {
        views.forEach { view in
            UIView.animate(withDuration: 0.1) {
                view.backgroundColor = isValid ? .green : .red
            }
        }
    }
}

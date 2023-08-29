//
//  PasscodeVC.swift
//  pinCodeScreen
//
//  Created by michail on 12.06.2023.
//

import UIKit

final class PasscodeVC: UIViewController {
    @IBOutlet private weak var pinView: PinView!
    @IBOutlet private weak var keyboardView: NumberPadView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    private var pin = ""
    
    private var errorWasAppeared: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    private func configureView() {
        keyboardView.delegate = self
        activityIndicator.isHidden = true
    }
    
    private func verifyPin() {
        keyboardView.disableKeyboard()
        validationPassword()
    }
    
    private func validationPassword() {
        errorWasAppeared = false
        if pin == "1234" {
            pinView.validPassword()
            activityIndicator.isHidden = false
            activityIndicator.startAnimating()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
                self?.activityIndicator.stopAnimating()
                self?.activityIndicator.isHidden = true
                self?.navigationController?.pushViewController(CompletedVC(), animated: true)
            }
        } else {
            inavalidPassword()
            pin = ""
            errorWasAppeared = true
        }
    }
    
    private func inavalidPassword() {
        pinView.invalidPassword()
        keyboardView.enableKeyboard()
    }
    
    private func itemWasSelected(_ index: Int) {
        if pin == "" && errorWasAppeared {
            pinView.resetDots()
        }
        errorWasAppeared = false
        pin += "\(index + 1)"
        guard 0 < pin.count && pin.count < 5 else {
            pinView.resetDots()
            return
        }
        
        if pin.count == 4 {
            verifyPin()
            return
        }
        pinView.configureDot(pin.count - 1, type: .append)
    }
    
    private func removeItem() {
        guard !pin.isEmpty else {
            if errorWasAppeared {
                pinView.resetDots()
            }
            return
        }
        pin.removeLast()
        pinView.configureDot(pin.count, type: .remove)
    }
}

extension PasscodeVC: NumberPadViewDelegate {
    func selectedItem(index: Int) {
        itemWasSelected(index)
    }
    
    func remove() {
        removeItem()
    }
}

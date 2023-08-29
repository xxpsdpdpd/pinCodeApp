//
//  NSObject+Extension.swift
//  pinCodeScreen
//
//  Created by michail on 12.06.2023.
//

import Foundation

extension NSObject {
    
    var className: String {
        String(describing: type(of: self))
    }
    
    class var className: String {
        String(describing: self)
    }
}

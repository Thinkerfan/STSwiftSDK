//
//  EXObject.swift
//  Extension Module
//
//  Created by cfans on 2018/11/10.
//  Copyright © 2018 cfans. All rights reserved.
//  swift Version 4.2
//  xcode Version 10.1 (10B61)
//

import Foundation

extension NSObject {
    var className: String {
        return NSStringFromClass(type(of: self))
    }

    class var className: String {
        return String(describing: self)
    }
}

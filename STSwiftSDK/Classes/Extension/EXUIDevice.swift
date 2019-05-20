//
//  EXUIDevice.swift
//  Module
//
//  Created by cfans on 2019/3/17.
//  Copyright © 2019 cfans. All rights reserved.
//

import UIKit

extension UIDevice {
    public func isX() -> Bool {
        if UIScreen.main.bounds.height == 812 {
            return true
        }
        return false
    }
    
    public func isdeviceX() -> Bool{
        switch UIScreen.main.nativeBounds.height {
        case 1136:
            print("iPhone 5 or 5S or 5C")
            fallthrough
        case 1334:
            print("iPhone 6/6S/7/8")
            fallthrough
        case 1920, 2208:
            print("iPhone 6+/6S+/7+/8+")
            return false
        case 2436:
            print("iPhone X, XS")
            fallthrough

        case 2688:
            print("iPhone XS Max")
            fallthrough

        case 1792:
            print("iPhone XR")
            fallthrough

        default:
            print("Unknown")
            return true
        }
    }
    
}

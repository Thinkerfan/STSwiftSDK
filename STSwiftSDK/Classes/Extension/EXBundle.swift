//
//  EXBundle.swift
//  STSWiftSDK
//
//  Created by cfans on 2018/10/4.
//  Copyright © 2018年 cfans. All rights reserved.
//

import UIKit
extension Bundle {
    public static func appName() -> String {
        guard let dictionary = Bundle.main.infoDictionary else {
            return ""
        }
        if let name : String = dictionary["CFBundleDisplayName"] as? String {
            return name
        } else {
            return ""
        }
    }

    public static func appVersion() -> String {
        guard let dictionary = Bundle.main.infoDictionary else {
            return "V1.0.1"
        }
        if let version : String = dictionary["CFBundleShortVersionString"] as? String {
            return version
        } else {
            return "V1.0.1"
        }
    }
    
   public static func appBundleID() -> String {
        return Bundle.main.bundleIdentifier!
    }
}

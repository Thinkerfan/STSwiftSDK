//
//  EXUIBarButtonItem.swift
//  App
//
//  Created by cfans on 2019/4/28.
//  Copyright © 2019 cfans. All rights reserved.
//

import UIKit

extension UIBarButtonItem{
    static func cfBarButton(title:String,target: Any?,action:String)->UIBarButtonItem{
        return UIBarButtonItem(title:title, style: .plain, target: target, action: Selector(action))
    }
}

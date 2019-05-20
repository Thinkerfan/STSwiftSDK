//
//  EXUIFont.swift
//  TodoList
//
//  Created by cfans on 2018/12/27.
//  Copyright © 2018 cfans. All rights reserved.
//

import UIKit

extension UIFont{

    class func pingFangSCFont(ofSize fontSize: CGFloat,style:String="Regular") -> UIFont{
        return UIFont(name: "PingFangSC-\(style)", size: fontSize)!
    }

}

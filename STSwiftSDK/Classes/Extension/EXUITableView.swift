//
//  EXUITableView.swift
//  IP Location
//
//  Created by cfans on 2018/10/7.
//  Copyright © 2018年 cfans. All rights reserved.
//

import UIKit
class SearchbarTableView:UITableView{
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.superview?.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
}

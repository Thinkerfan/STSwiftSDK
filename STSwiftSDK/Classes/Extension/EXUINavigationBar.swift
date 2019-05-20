//
//  EXUINavagationBar.swift
//  TodoList
//
//  Created by cfans on 2019/1/7.
//  Copyright © 2019 cfans. All rights reserved.
//

import UIKit
class CFNavigationBar:UIView{

    var lbTitle:UILabel!
    var btnBack:UIButton!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews(){
        let width:CGFloat = 40
        var rect = CGRect(x:0 , y: 20, width: width, height: width)
        btnBack = UIButton(frame: rect)
        btnBack.setImage(UIImage(named: "VCWebBack@3x"), for: .normal)
        addSubview(btnBack)

        rect.origin.x = width
        rect.size.width = self.frame.width - width * 2
        lbTitle = UILabel(frame: rect)
        lbTitle.textAlignment = .center
        lbTitle.font = UIFont.pingFangSCFont(ofSize: 18, style: "Medium")
        lbTitle.adjustsFontSizeToFitWidth = true
        addSubview(lbTitle)

        let line = UIView(frame: CGRect(x: 0, y:65.5, width: self.frame.width, height: 0.5))
        line.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        addSubview(line)

    }
}

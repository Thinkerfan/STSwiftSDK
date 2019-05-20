//
//  EXUIButton.swift
//  Module
//
//  Created by cfans on 2018/9/29.
//  Copyright © 2018年 cfans. All rights reserved.
//
import UIKit

@IBDesignable class EXUIButton: UIButton {

    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }


    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }

    @IBInspectable var borderColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
}

extension UIButton{

    func timeCount(seconds:Int,endText:String){
        self.isEnabled = false
        var count = seconds
        let codeTimer = DispatchSource.makeTimerSource(flags: .init(rawValue: 0), queue: DispatchQueue.global())
        codeTimer.schedule(deadline: .now(), repeating: .seconds(1))
        codeTimer.setEventHandler {
            count = count - 1
            if count < 0 {
                codeTimer.cancel()
                DispatchQueue.main.async {
                    self.isEnabled = true
                    self.setTitle(endText, for: .normal)
                }
            }else{
                DispatchQueue.main.async {
                    self.setTitle("\(count) s", for: .normal)
                }
            }
        }
        codeTimer.activate()
    }
    
    static func cfBtn(title:String) ->UIButton{
        let btn = UIButton()
        btn.setTitle(title, for: .normal)
        return btn
    }
    
    static func cfBtn(img:String) ->UIButton{
        let btn = UIButton()
        btn.setImage(UIImage(named: img), for: .normal)
        return btn
    }
}

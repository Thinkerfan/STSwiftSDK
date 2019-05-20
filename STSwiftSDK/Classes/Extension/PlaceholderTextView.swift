//
//  PlaceholderTextView.swift
//  QRCode
//
//  Created by cfans on 2018/12/17.
//  Copyright © 2018 cfans. All rights reserved.
//

import UIKit

@IBDesignable class PlaceholderTextView: UITextView {
    
    @IBInspectable var contentColor:UIColor = .black
    @IBInspectable var placeHolderColor:UIColor = .placeholderGray
    @IBInspectable var placeHolderStr:String = ""{
        didSet{
            text = placeHolderStr
            textColor = placeHolderColor
        }
    }

    override var text: String!{
        didSet{
            textColor = contentColor
        }
    }
    var bolderWidth: CGFloat!{
        didSet{
            layer.borderWidth = bolderWidth
        }
    }

    var content:String?{
        get{
            return (text==placeHolderStr||text.count==0) ? nil : text
        }
    }

    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        setupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }

    private func setupViews(){
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.placeholderGray.cgColor
        layer.cornerRadius = 5.0
        NotificationCenter.default.addObserver(self, selector: #selector(textDidBeginEditing), name: UITextView.textDidBeginEditingNotification, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(textDidEndEditing), name: UITextView.textDidEndEditingNotification, object: nil);
    }

    @objc func textDidBeginEditing(){
        if self.text == placeHolderStr{
            self.text = "";
            self.textColor = contentColor
        }
    }

    @objc func textDidEndEditing(){
        if self.text.count == 0 {
            self.text = placeHolderStr
            self.textColor = placeHolderColor
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }


}

//
//  EXUIColor.swift
//  Module
//
//  Created by cfans on 2018/11/1.
//  Copyright © 2018 cfans. All rights reserved.
//

import UIKit

extension UIColor {
    
    convenience init(rgb: Int, alpha: CGFloat = 1.0) {
        self.init(
            red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgb & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }

    static var RGBColor: (CGFloat, CGFloat, CGFloat) -> UIColor = {red, green, blue in
        return UIColor(red: red / 255, green: green / 255, blue: blue / 255, alpha: 1);
    }

    static var RGBAColor: (CGFloat, CGFloat, CGFloat, CGFloat) -> UIColor = {red, green, blue, alpha in
        return UIColor(red: red / 255, green: green / 255, blue: blue / 255, alpha: alpha);
    }
    
    func image(_ size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { rendererContext in
            self.setFill()
            rendererContext.fill(CGRect(x: 0, y: 0, width: size.width, height: size.height))
        }
    }

    static var placeholderGray: UIColor {
        return UIColor(red: 0, green: 0, blue: 0.0980392, alpha: 0.22)
    }

    static func colorFromImage(image:UIImage)->UIColor{
       return UIColor.init(patternImage: image)
    }
    
    static func colorFromUserDefault(key:String,defColor:UIColor = UIColor.RGBColor(00,0x79,0x79)) -> UIColor?{
        if let cData = UserDefaults.standard.object(forKey: key) as? Data{
            if let color = NSKeyedUnarchiver.unarchiveObject(with: cData) as? UIColor{
                return color
            }
        }
        return defColor
    }
    
    static func colorToUserDefault(key:String,color:UIColor){
        let data : NSData = NSKeyedArchiver.archivedData(withRootObject: color) as NSData
        UserDefaults.standard.set(data, forKey: key)
        UserDefaults.standard.synchronize()
    }

}

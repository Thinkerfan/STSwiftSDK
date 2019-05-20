//
//  EXUITabbar.swift
//  Song
//
//  Created by cfans on 2018/11/15.
//  Copyright © 2018 cfans. All rights reserved.
//

import UIKit
extension UITabBar{

    /**
     隐藏顶部一条黑线
     */
    func hideTopLine(){
        self.shadowImage = UIImage()
        self.backgroundImage = UIImage()
    }

}

// 关联对象的ID,注意，在私有嵌套 struct 中使用 static var，这样会生成我们所需的关联对象键，但不会污染整个命名空间
// 定义一个新的tabbar属性,并设置set,get方法
extension UITabBar{

    private struct AssociatedKeys {
        static var TabCenterButton = "centerButton"
    }

    var centerTab:UIButton?{
        get{
            //通过Key获取已存在的对象
            return objc_getAssociatedObject(self, &AssociatedKeys.TabCenterButton) as? UIButton
        }
        set{
            //对象不存在则创建
            objc_setAssociatedObject(self, &AssociatedKeys.TabCenterButton, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    /**
     添加中心按钮
     */
    func addCenterTab(image:String)->UIButton
    {
        if self.centerTab == nil
        {
            let btn = UIButton(frame: CGRect.init(x: (self.bounds.width - 50) / 2, y: 0, width: 50, height: 50))
            btn.autoresizingMask = [.flexibleHeight,.flexibleWidth]
            btn.setImage(UIImage(named: image)?.withRenderingMode(.alwaysOriginal), for:.normal)
            self.addSubview(btn)
            self.centerTab = btn
        }
        return self.centerTab!
    }
}
class CFTabbar:UITabBar{
    var itemFrames = [CGRect]()
    var tabBarItems = [UIView]()


    override func layoutSubviews() {
        super.layoutSubviews()

        if itemFrames.isEmpty, let UITabBarButtonClass = NSClassFromString("UITabBarButton") as? NSObject.Type {
            tabBarItems = subviews.filter({$0.isKind(of: UITabBarButtonClass)})
            tabBarItems.forEach({itemFrames.append($0.frame)})
        }

        if !itemFrames.isEmpty, !tabBarItems.isEmpty, itemFrames.count == items?.count {
            tabBarItems.enumerated().forEach({$0.element.frame = itemFrames[$0.offset]})
        }
    }
    
}

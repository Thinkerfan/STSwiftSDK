//
//  EXUINavigationBart.swift
//  AliSC
//
//  Created by cfans on 2018/9/14.
//  Copyright © 2018年 cfans. All rights reserved.
//
import UIKit

extension UINavigationController {

    /**
     隐藏navigationBar底部一条黑线
     */
    func hideBottomLine(){
        self.navigationBar.shadowImage = UIImage()
    }
    
    func setBarTransparent(){
        self.navigationBar.isTranslucent = true
        self.navigationBar.setBackgroundImage(UIImage.colorForNavBar(color: UIColor.clear), for: .default)
        self.navigationBar.shadowImage = UIImage()
    }

    func pushViewControllerWithoutBackButtonTitle(_ viewController: UIViewController, animated: Bool = true) {
        viewControllers.last?.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        viewController.hidesBottomBarWhenPushed = true
        pushViewController(viewController, animated: animated)
    }

    /**
        设置navigationBar渐变背景色
     */
    func setBarGradientColor(colors:[UIColor],start:CGPoint = CGPoint(x: 1, y: 0),end:CGPoint = CGPoint(x: 1, y: 1) ){
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.locations = [0.0 ,1.0]
        gradient.startPoint = start
        gradient.endPoint = end

        var updatedFrame = navigationBar.bounds
        updatedFrame.size.height +=   UIApplication.shared.statusBarFrame.height
        gradient.frame = updatedFrame
        let cgcolors = colors.map { $0.cgColor }
        gradient.colors = cgcolors
        
        navigationBar.setBackgroundImage(UIImage.image(fromLayer: gradient), for: .default)
    }

}


//
//  EXView.swift
//  AliSC
//
//  Created by cfans on 2018/9/17.
//  Copyright © 2018年 cfans. All rights reserved.
//
import UIKit

extension UIView {
    
    class func loadFromNibNamed(nibNamed: String, bundle: Bundle? = nil) -> UIView? {
        return UINib(
            nibName: nibNamed,
            bundle: bundle
            ).instantiate(withOwner: nil, options: nil)[0] as? UIView
    }

    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
    func setBackgroundImage(image:String){
        //        let backgroundImage = UIImageView@objc (frame: @objc UIScreen.main.bounds)
//        backgroundImage.image = UIImage(named: image)
//        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
//        self.insertSubview(backgroundImage, at: 0)

        UIGraphicsBeginImageContext(self.frame.size);
        UIImage(named: image)?.draw(in: self.frame)
        let image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        self.backgroundColor = UIColor.init(patternImage: image!)
    }

    func addScaleAnim(from:Float = 1,to:Float = 0.9,duration:Double = 1.5){
        let scaleAnim = CABasicAnimation(keyPath: "transform.scale")
        scaleAnim.fromValue = from
        scaleAnim.toValue = to
        scaleAnim.duration = duration
        scaleAnim.repeatCount = HUGE //无限重复
        scaleAnim.autoreverses = true //动画结束时执行逆动画
        scaleAnim.isRemovedOnCompletion = false //切出此界面再回来动画不会停
        self.layer.removeAllAnimations()
        self.layer.add(scaleAnim, forKey: "centerLayer")
    }

    func mkBaseAnim(keyPath:String)->CABasicAnimation{
        let anim = CABasicAnimation(keyPath: keyPath)
        anim.toValue = Double.pi * 2
        anim.duration = 1.5;
        anim.isRemovedOnCompletion = false
        anim.repeatCount = HUGE;
        return anim
    }
    
    func addGradientLayer(
        start: CGPoint = CGPoint(x: 0, y: 0), //渐变起点
        end: CGPoint = CGPoint(x: 1, y: 1), //渐变终点
        frame: CGRect,
        colors: [UIColor]
        ) {
        layoutIfNeeded()
        removeGradientLayer()
        let gradientLayer = CAGradientLayer()
        gradientLayer.startPoint = start
        gradientLayer.endPoint = end
        gradientLayer.frame = frame
        var cgColors = [CGColor]()
        for color in colors{
            cgColors.append(color.cgColor)
        }
        gradientLayer.colors = cgColors
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func removeGradientLayer() {
        guard let layers = self.layer.sublayers else { return }
        for layer in layers {
            if layer.isKind(of: CAGradientLayer.self) {
                layer.removeFromSuperlayer()
            }
        }
    }
}

extension UIView {
    /**
     View 截图
     */
    func snapShot() -> UIImage?{
        var image:UIImage?
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, true, 0);
        if self.drawHierarchy(in: self.bounds, afterScreenUpdates: true){
            image = UIGraphicsGetImageFromCurrentImageContext();
        }
        UIGraphicsEndImageContext();
        return image;
    }
    /**
     * 画网格线
     */
    func drawGrid(column:Int,row:Int,pathWidth:CGFloat = 5,pathColor:UIColor = .white){
        let path = UIBezierPath()
        
        let width = self.bounds.width
        let height = self.bounds.height
        
        let gridWidth = width/CGFloat(column)
        let gridHeight = height/CGFloat(row)
        
        for i in 1..<column{
            let start = CGPoint(x: CGFloat(i) * gridWidth, y: 0)
            let end = CGPoint(x: CGFloat(i) * gridWidth, y:height)
            path.move(to: start)
            path.addLine(to: end)
        }
        
        for i in 1..<row{
            let start = CGPoint(x: 0, y: CGFloat(i) * gridHeight)
            let end = CGPoint(x:width,y: CGFloat(i) * gridHeight)
            path.move(to: start)
            path.addLine(to: end)
        }
        
        path.close()
        let layer = CAShapeLayer()
        layer.path = path.cgPath
        layer.lineWidth = pathWidth
        layer.strokeColor = pathColor.cgColor
        self.layer.addSublayer(layer)
    }
}

class ViewWithBgGradient:UIView{
    
    var gradientColors:[UIColor]!
    var start:CGPoint =  CGPoint(x: 0, y: 0)//渐变起点
    var end:CGPoint = CGPoint(x: 1, y: 1) //渐变终点
    

    override func layoutSubviews() {
        super.layoutSubviews()
        if let gradient = gradientColors{
            addGradientLayer(start: start, end: end, frame: self.bounds, colors: gradient)
        }
    }
    
}

// MARK: - UIView + Frame Extension
extension UIView {
    
    /* X */
    public var x : CGFloat {
        get {
            return self.frame.origin.x
        }
        
        set {
            var frame = self.frame
            frame.origin.x = x
            self.frame = frame
        }
    }
    
    /* Y */
    public var y : CGFloat {
        get {
            return self.frame.origin.y
        }
        
        set {
            var frame = self.frame
            frame.origin.y = y
            self.frame = frame
        }
    }
    
    /* Width */
    public var width : CGFloat {
        get {
            return self.frame.size.width
        }
        
        set {
            var frame = self.frame
            frame.size.width = width
            self.frame = frame
        }
    }
    
    /* Height */
    public var height : CGFloat {
        get {
            return self.frame.size.height
        }
        
        set {
            var frame = self.frame
            frame.size.height = height
            self.frame = frame
        }
    }
    
    /* Origin */
    public var origin : CGPoint {
        get {
            return self.frame.origin
        }
        
        set {
            var frame = self.frame
            frame.origin = origin
            self.frame = frame
        }
    }
    
    /* Size */
    public var size : CGSize {
        get {
            return self.frame.size
        }
        
        set {
            var frame = self.frame
            frame.size = size
            self.frame = frame
        }
    }
}

// MARK: - CALayer + Frame Extension
extension CALayer {
    /* X */
    public var x : CGFloat {
        get {
            return self.frame.origin.x
        }
        
        set {
            var frame = self.frame
            frame.origin.x = x
            self.frame = frame
        }
    }
    
    /* Y */
    public var y : CGFloat {
        get {
            return self.frame.origin.y
        }
        
        set {
            var frame = self.frame
            frame.origin.y = y
            self.frame = frame
        }
    }
    
    /* Width */
    public var width : CGFloat {
        get {
            return self.frame.size.width
        }
        
        set {
            var frame = self.frame
            frame.size.width = width
            self.frame = frame
        }
    }
    
    /* Height */
    public var height : CGFloat {
        get {
            return self.frame.size.height
        }
        
        set {
            var frame = self.frame
            frame.size.height = height
            self.frame = frame
        }
    }
    
    /* Origin */
    public var origin : CGPoint {
        get {
            return self.frame.origin
        }
        
        set {
            var frame = self.frame
            frame.origin = origin
            self.frame = frame
        }
    }
    
    /* Size */
    public var size : CGSize {
        get {
            return self.frame.size
        }
        
        set {
            var frame = self.frame
            frame.size = size
            self.frame = frame
        }
    }
}

//
//  EXUIImageView.swift
//  AliSC
//
//  Created by cfans on 2018/9/30.
//  Copyright © 2018年 cfans. All rights reserved.
//

import UIKit

@IBDesignable
class UIImageViewWithMask: UIImageView {
    
    private var maskImageView = UIImageView()
    private var maskingImageView = UIImageView()

    @IBInspectable var showOpacity:Float = 0 {
        didSet{
           layer.shadowOpacity = showOpacity
        }
    }
    
    @IBInspectable var maskImage:UIImage?{
        didSet{
            maskImageView.image = maskImage
            updateView()
        }
    }
    
    @IBInspectable var shadeColor:UIColor = .clear {
        didSet{
            layer.shadowColor = shadeColor.cgColor
        }
    }
    
    @IBInspectable var shadowRadius:CGFloat = 0 {
        didSet{
            layer.shadowRadius = shadowRadius
        }
    }
    
    
    @IBInspectable var shadowOffset:CGSize = CGSize(width: 0, height: 0) {
        didSet{
            layer.shadowOffset = shadowOffset
        }
    }
    
    func updateView(){

        if maskImageView.image != nil{
            maskImageView.frame = bounds
            maskImageView.contentMode = .scaleAspectFit
            
            maskingImageView.frame = bounds
            maskingImageView.image = image
            maskingImageView.contentMode = .scaleAspectFit
            
            maskImageView.layer.mask = maskingImageView.layer
            maskImageView.removeFromSuperview()
            addSubview(maskImageView)
        }
    }
}


@IBDesignable class EXUIImageView: UIImageView {

    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
            self.clipsToBounds = true
        }
        get {
            return layer.cornerRadius
        }
    }
}

class CFRotateAnimIV:UIImageView{

    var isRotating: Bool = false
    func addRotateAnim(){
        let anim = CABasicAnimation(keyPath: "transform.rotation.z")
        anim.toValue = Double.pi * 2
        anim.isCumulative = false
        anim.isRemovedOnCompletion = false
        anim.repeatCount = HUGE;
        anim.duration = 60
        anim.timingFunction = CAMediaTimingFunction.init(name:CAMediaTimingFunctionName.linear)
        self.layer.add(anim, forKey: "AnimatedKey")
        self.layer.speed = 0.0;
        self.layer.cornerRadius = self.bounds.width/2
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 5;
        self.clipsToBounds = true

    }

     func rotate(rotate:Bool){
        if rotate {
            animStart()
        }else{
            animStop()
        }
    }

    private func animStart(){
        if !isRotating {
            isRotating = true
            let pausedTime = self.layer.timeOffset
            self.layer.timeOffset = 0
            self.layer.beginTime = 0
            let timeSincePause = self.layer.convertTime(CACurrentMediaTime(), to: nil) - pausedTime
            self.layer.beginTime = timeSincePause;
            self.layer.speed = 1
        }
    }

    private func animStop(){
        if isRotating {
            isRotating = false
            let pausedTime = self.layer.convertTime(CACurrentMediaTime(), to: nil)
            self.layer.speed = 0;
            self.layer.timeOffset = pausedTime;
        }
    }
    
}
// mark 画grid分割线
extension UIImageView{
    func drawGridLine(count:Int,color:UIColor = UIColor.lightGray){
        let imageSize:CGFloat = min(self.bounds.width,self.bounds.height)
        let size = CGFloat(count)
        let path = UIBezierPath()
        let shapeLayer = CAShapeLayer()
        shapeLayer.lineWidth = 1
        shapeLayer.strokeColor = color.cgColor
        for x in 1..<count {
            path.move(to: CGPoint(x: imageSize*CGFloat(x)/size, y: 0))
            path.addLine(to: CGPoint(x: imageSize*CGFloat(x)/size, y: self.bounds.height))
        }

        for y in 1..<count {
            path.move(to: CGPoint(x: 0, y:imageSize*CGFloat(y)/size ))
            path.addLine(to: CGPoint(x:self.bounds.width , y: imageSize*CGFloat(y)/size))
        }
        shapeLayer.path = path.cgPath
        self.layer.addSublayer(shapeLayer)
    }
}

// mark 画Bezier分割线
extension UIImageView{
    func drawBezierPath(path:UIBezierPath,color:UIColor = UIColor.lightGray){
        let shapeLayer = CAShapeLayer()
        shapeLayer.lineWidth = 1
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.path = path.cgPath
        self.layer.addSublayer(shapeLayer)
    }
}

// mark 加载小量的网络图片接口，大量图片加载请用第三库

let imageCache = NSCache<NSString, UIImage>()
extension UIImageView {

    func imageFromUrl(urlString : String) {

        // check cached image
        if let cachedImage = imageCache.object(forKey: urlString as NSString)  {
            self.image = cachedImage
            return
        }

        guard let url = URL(string: urlString) else{
            return
        }
//        let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView.init(activityIndicatorStyle: .gray)
//        addSubview(activityIndicator)
//        activityIndicator.startAnimating()
//        activityIndicator.center = self.center

        // if not, download image from url
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }

            DispatchQueue.main.async {
                if let image = UIImage(data: data!) {
                    imageCache.setObject(image, forKey: urlString as NSString)
                    self.image = image
//                    activityIndicator.removeFromSuperview()
                }
            }

        }).resume()
    }
}


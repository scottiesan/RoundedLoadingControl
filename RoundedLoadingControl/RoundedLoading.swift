//
//  RoundedLoading.swift
//  RoundedLoadingControl
//
//  Created by Scott Ho on 12/3/16.
//  Copyright © 2016 Scott Ho. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedLoading: UIView {
    
    
    var percentageLabel = UILabel()
    var range:CGFloat = 100
    var currentValue:CGFloat = 0 {
        didSet{
            animate()
        }
    }
    let margin:CGFloat = 0
    
    let bgLayer = CAShapeLayer()
    let fgLayer = CAShapeLayer()
    
    @IBInspectable var bgColor:UIColor = UIColor.black {
        didSet {
            configure()
        }
    }
    
    @IBInspectable var fgColor:UIColor = UIColor.blue {
        didSet {
            configure()
        }
    }
    
    @IBInspectable var lineWidth:CGFloat = 10 {
        didSet {
            configure()
        }
    }
    
    private func setup(){
        
        bgLayer.fillColor = nil
        bgLayer.strokeEnd = 1
        
        fgLayer.fillColor = nil
        fgLayer.strokeEnd = 0
        
        layer.addSublayer(bgLayer)
        layer.addSublayer(fgLayer)
        
        percentageLabel.font = UIFont.systemFont(ofSize: 14)
        percentageLabel.textColor = UIColor.black
        percentageLabel.translatesAutoresizingMaskIntoConstraints = false
        percentageLabel.text = "0%"
        addSubview(percentageLabel)
        
        let labelCenterX = percentageLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        let labelCenterY = percentageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: margin)
        NSLayoutConstraint.activate([labelCenterX, labelCenterY])
        
    }
    
    private func configure(){
        let cur = Int(currentValue)
        percentageLabel.text = String("\(cur)%")
        bgLayer.strokeColor = bgColor.cgColor
        fgLayer.strokeColor = fgColor.cgColor
        bgLayer.lineWidth = lineWidth
        fgLayer.lineWidth = lineWidth
    }
    
    private func setupShapeLayer (shapeLayer: CAShapeLayer){
        
        shapeLayer.frame = self.bounds
        let startAngle = DegreesToRadians(270.0001)
        let endAngle = DegreesToRadians(270)
        let center = percentageLabel.center
        let radius = self.bounds.width * 0.35
        let path = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        shapeLayer.path = path.cgPath
    }
    
    func DegreesToRadians (_ value:CGFloat) -> CGFloat {
        return value * CGFloat(M_PI) / 180.0
    }
    
    func RadiansToDegrees (_ value:CGFloat) -> CGFloat {
        return value * 180.0 / CGFloat(M_PI)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setupShapeLayer(shapeLayer: bgLayer)
        setupShapeLayer(shapeLayer: fgLayer)
    }
    
    override func awakeFromNib() {
        setup()
        configure()
    }
    
    override func prepareForInterfaceBuilder() {
        setup()
        configure()
    }
    fileprivate func animate() {
        
        let cur = Int(currentValue)
        percentageLabel.text = String("\(cur)%")
        
        var fromValue = fgLayer.strokeStart
        let toValue = currentValue / range
        if let presentationLayer = fgLayer.presentation()  {
            fromValue = presentationLayer.strokeEnd
        }
        let percentChange = abs(fromValue - toValue)
        
        // 1
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = fromValue
        animation.toValue = toValue
        
        // 2
        animation.duration = CFTimeInterval(percentChange * 4)
        
        // 3
        fgLayer.removeAnimation(forKey: "stroke")
        fgLayer.add(animation, forKey: "stroke")
        
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        fgLayer.strokeEnd = toValue
        CATransaction.commit()
    }


}

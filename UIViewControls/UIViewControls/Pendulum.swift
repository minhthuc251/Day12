//
//  Pendulum.swift
//  UIViewControls
//
//  Created by Thuc Nguyen Minh on 9/30/14.
//  Copyright (c) 2014 Techmaster. All rights reserved.
//

import UIKit
let maxAngle = M_PI_4 * 0.5
class Pendulum: UIViewController {
    var pendulum: UIImageView = UIImageView()
    var slider: UISlider?
    var timer : NSTimer?
    var angle : Double = 0
    var angleDelta : Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "animatePendulum:", userInfo: nil , repeats: true)
        timer?.fire()
    }
    
    override func loadView() {
        super.loadView()
        self.view.backgroundColor = UIColor.whiteColor()
        self.edgesForExtendedLayout = UIRectEdge.None
        pendulum.image = UIImage(named: "pendulum.png")
        pendulum.frame = CGRect(x: self.view.bounds.size.width * 0.5, y: 100, width: 42, height: 291)
        self.view.addSubview(pendulum)
        var size :CGSize = self.pendulum.bounds.size
        slider = UISlider(frame: CGRect(x: 0, y: 355, width: 200, height: 40))
        slider!.addTarget(self, action: "changeAngle:", forControlEvents: UIControlEvents.ValueChanged)
        self.view.addSubview(slider!)
        self.pendulum.layer.anchorPoint = CGPointMake(0.5, 0)
        self.pendulum.frame = CGRectMake((self.view.bounds.size.width - size.width) * 0.5, 20, size.width, size.height)
        angleDelta = 0.05
    }

    func animatePendulum(timer: NSTimer){
        angle += angleDelta
        if ((angle > maxAngle) | (angle < -maxAngle)){
            angleDelta = -angleDelta
        }
        self.pendulum.transform = CGAffineTransformMakeRotation(CGFloat(angle))
    }
    
    func changeAngle(slider: UISlider){
        self.pendulum.transform = CGAffineTransformMakeRotation(CGFloat(maxAngle * Double(slider.value)))
    }
}

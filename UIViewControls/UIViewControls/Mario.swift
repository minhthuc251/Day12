//
//  Mario.swift
//  UIViewControls
//
//  Created by Trinh Minh Cuong on 9/29/14.
//  Copyright (c) 2014 Techmaster. All rights reserved.
//

import UIKit

class Mario: UIViewController {
    var mario: UIImageView?
    var city1, city2, city3, city4, box , box2: UIImageView?
    var _timer: NSTimer?
    var viewHeight: Double = 0.0
    var moveX = 20
    let cityWidth: Double = 1498
    let cityHeight: Double = 400
    var velY: Double = 0.0
    var accY: Double = 14.0
    var y : Double = 0
    var x : CGFloat = 0
    var boxX : Double = 40
    var boxY : Double = 40
    var maxHeight: Double = 0.0
    var jumped : Bool = false
    var minHeight : Double = 450
    var tapNext : Bool = false
    var highJump : Bool = false
    var point : Int = 0
    var pointLabel : UILabel = UILabel()
    var gameOverLabel : UILabel = UILabel()
    var gameOverView : UIView!
    var gameOverY : Double = 0
    override func loadView() {
        super.loadView()
        self.view.backgroundColor = UIColor.whiteColor()
        self.edgesForExtendedLayout = UIRectEdge.None
        let viewSize = self.view.bounds.size
        viewHeight = Double(viewSize.height) - 60
        
        
        city1 = UIImageView(frame: CGRect(x: 0, y: viewHeight - cityHeight, width: cityWidth, height: cityHeight))
        city1!.image = UIImage(named: "city1.png")
        self.view.addSubview(city1!)
       /*
        city2 = UIImageView(frame: CGRect(x: cityWidth, y: viewHeight - cityHeight, width: cityWidth, height: cityHeight))
        city2!.image = UIImage(named: "city2.png")
        self.view.addSubview(city2!)
        
        city3 = UIImageView(frame: CGRect(x: cityWidth * 2, y: viewHeight - cityHeight, width: cityWidth, height: cityHeight))
        city3!.image = UIImage(named: "city3.png")
        self.view.addSubview(city3!) */
        
        city4 = UIImageView(frame: CGRect(x: cityWidth, y: viewHeight - cityHeight, width: cityWidth, height: cityHeight))
        city4!.image = UIImage(named: "city1.png")
        self.view.addSubview(city4!)
        
        box = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        box?.image = UIImage(named: "box.jpg")
        box!.center = CGPoint(x: viewSize.width , y: CGFloat(viewHeight) - 10 - CGFloat(boxY) * 0.5)
        box2 = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        box2?.image = UIImage(named: "box2.jpg")
        box2!.center = CGPoint(x: viewSize.width - 20, y: CGFloat(viewHeight) - 10 - CGFloat(boxY) * 0.5)
        self.view.addSubview(box!)
        //self.view.addSubview(box2!)
        
        gameOverView = UIView(frame: CGRect(x: 25 , y: -250, width: 400, height: 200))
        gameOverLabel = UILabel(frame: CGRect(x: 0 , y: 0, width: 150  , height: 80))
        gameOverLabel.center = CGPoint(x: gameOverView.bounds.size.width * 0.5, y: gameOverView.bounds.size.height * 0.5)
        gameOverLabel.text = "Game Over !!!"
        gameOverLabel.backgroundColor = UIColor.greenColor()
        gameOverLabel.textColor = UIColor.redColor()
        gameOverLabel.textAlignment = NSTextAlignment.Center
        gameOverView.addSubview(gameOverLabel)
        self.view.addSubview(gameOverView)
        
        
        pointLabel = UILabel(frame: CGRect(x: viewSize.width - 100, y: 20, width: 70, height: 30))
        pointLabel.text = "Point : 0"
        self.view.addSubview(pointLabel)
        
        gameOverLabel = UILabel(frame: CGRect(x: viewSize.width - 200, y: 50, width: 250, height: 250))
        
        mario = UIImageView(frame: CGRect(x: 0, y: 0, width: 65, height: 102))
        mario?.center = CGPoint(x: viewSize.width * 0.5 - 130, y: CGFloat(viewHeight) - 10 - mario!.bounds.size.height * 0.5)
        mario!.userInteractionEnabled = true
        mario!.multipleTouchEnabled = true
        mario!.animationImages = [
            UIImage(named: "1.png"),
            UIImage(named: "2.png"),
            UIImage(named: "3.png"),
            UIImage(named: "4.png"),
            UIImage(named: "5.png"),
            UIImage(named: "6.png"),
            UIImage(named: "7.png"),
            UIImage(named: "8.png")
        ]
        mario!.animationDuration = 1.0
        
        self.view.addSubview(mario!)
        mario!.startAnimating()
        maxHeight = viewHeight - 10 - Double(mario!.bounds.size.height) * 0.5
        x = viewSize.width * 0.5
        y = viewHeight - 10 - Double(mario!.bounds.size.height) * 0.5
        let tap = UITapGestureRecognizer(target: self, action: "tapOnMario")
        self.view.addGestureRecognizer(tap)
        
        self._timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "runCity", userInfo: nil, repeats: true)
        self._timer?.fire()
    }
    
    func runCity() {
        box!.center = CGPoint(x: box!.center.x - CGFloat(moveX), y: box!.center.y)
        if box!.frame.origin.x + 40 < 0 {
            box!.frame = CGRect(x: Double(box2!.frame.origin.x) + 40, y: Double(box!.frame.origin.y), width: 40, height: 40)
            point++
            pointLabel.text = "Point: \(point)"
        }
        if box2!.frame.origin.x + CGFloat(40) < 0 {
            box2!.frame = CGRect(x: Double(box!.frame.origin.x) + 40, y: Double(box!.frame.origin.y), width: 40, height: 40)
            point++
            pointLabel.text = "Point: \(point)"
        }
        city1!.center = CGPoint(x: city1!.center.x - CGFloat(moveX), y: city1!.center.y)
       /* city2!.center = CGPoint(x: city2!.center.x - CGFloat(moveX), y: city2!.center.y)
        city3!.center = CGPoint(x: city3!.center.x - CGFloat(moveX), y: city3!.center.y) */
        city4!.center = CGPoint(x: city4!.center.x - CGFloat(moveX), y: city4!.center.y)
        
        if city1!.frame.origin.x + CGFloat(cityWidth) < 0 {
            city1!.frame = CGRect(x: Double(city4!.frame.origin.x) + cityWidth, y: Double(city1!.frame.origin.y), width: cityWidth, height: cityHeight)
            println("move 1")
        }
        if city4!.frame.origin.x + CGFloat(cityWidth) < 0 {
            city4!.frame = CGRect(x: Double(city1!.frame.origin.x) + cityWidth, y: Double(city1!.frame.origin.y), width: cityWidth, height: cityHeight)
            println("move 2")
        }
        if ((mario!.center.x) < (box!.center.x + 20) && (mario!.center.x) > (box!.center.x - 20) && (mario!.center.y + 60) > (box!.center.y - 20)){
            UIView.animateWithDuration(1.0, animations: {
                self.gameOverView.center = CGPoint(x: 200, y: 200)
                println("\(self.gameOverY)")
                },
                completion:{finished in
            })
            _timer?.invalidate()
            _timer = nil
            pointLabel.text = "Point: \(point)"
            mario?.transform = CGAffineTransformMakeRotation(CGFloat(-M_PI / 2))
            
            
        }
        /*if ((mario!.center.x) < (box2!.center.x + 20) && (mario!.center.x) > (box2!.center.x - 20) && (mario!.center.y + 60) > (box2!.center.y - 20)){
            _timer?.invalidate()
            _timer = nil
            pointLabel.text = "Point: \(point)"
            mario?.transform = CGAffineTransformMakeRotation(CGFloat(-M_PI / 2))
            gameOverLabel.text = "GameOver!!!"
            gameOverLabel.textColor = UIColor.redColor()
        }*/
        if (jumped == true) {
            
            y -= accY
            
            if y < minHeight {
                accY *= -1
                y = minHeight
                
            }else if(y > maxHeight) {
                jumped = false
                accY *= -1
                y = maxHeight
            }
            
            mario?.center = CGPoint(x: Double(x) * 0.5, y: y)
            
        }
    
        
    }
    func tapOnMario() {
        jumped = true
    }
    

    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        _timer?.invalidate()
        _timer = nil
    }
}

//
//  Igulad.swift
//  ListOfNumbers
//
//  Created by Gitit Halevi on 30/03/2019.
//  Copyright © 2019 Gitit Halevi. All rights reserved.
//

import UIKit

class Igulad{
    
    var points: [CGPoint] = []
    var dot: UIView!
    var view: UIView!
    var isOn = false
    var lineOn: Int!
    
    
    init (view: UIView){
        let widthSize = view.frame.width / 9
        var xPoint: CGFloat = 0
        dot = UIView(frame: CGRect(x: 0, y: 0, width: widthSize, height: view.frame.height))
        dot.backgroundColor = UIColor.blue
        dot.isHidden = true
        view.addSubview(dot)
        
        for _ in 0..<10{
            points.append(CGPoint(x: xPoint, y: 0))
            xPoint += (widthSize)
        }
    }
    
    
    func startIgulad(){
        isOn = true
        dot.isHidden = false
        lineOn = 0
        runOnLines()
    }
    
    func stopIgulad(){
        dot.isHidden = true
        isOn = false
    }
    
    func runOnLines(){
        if !isOn{
            return
        }
        let popTime = DispatchTime(uptimeNanoseconds:     DispatchTime.now().uptimeNanoseconds + NSEC_PER_SEC / 3)
        DispatchQueue.main.asyncAfter(deadline: popTime) {
            self.dot.frame.origin = self.points[self.lineOn]
            self.lineOn += 1
            if self.lineOn > 9{
                self.lineOn = 0
            }
            self.runOnLines()
            
        }
        
			
        
    }
    
}

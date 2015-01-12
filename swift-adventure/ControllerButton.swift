//
//  ControllerButton.swift
//  swift-adventure
//
//  Created by 安部裕介 on 1/11/15.
//  Copyright (c) 2015 MyAwesomeCompany. All rights reserved.
//

import SpriteKit

class ControllerButton: SKSpriteNode {
    var hitbox: (CGPoint -> Bool)?
    
    convenience init(imageNamed: String, position: CGPoint) {
        self.init(imageNamed: named)
        self.texture?.filteringMode = .Nearest
        self.setScale(2.0)
        self.alpha = 0.2
        self.position = position
        
        hitbox = { (location: CGPoint) -> Bool in return self.containsPoint(location)}
    }
    
    func hitboxContainsPoint(location: CGPoint) -> Bool {
        return hitbox!(location)
    }
}
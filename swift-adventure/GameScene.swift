//
//  GameScene.swift
//  swift-adventure
//
//  Created by 安部裕介 on 1/11/15.
//  Copyright (c) 2015 MyAwesomeCompany. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    var destination: CGPoint!
    
    let hero = SKSpriteNode(imageNamed: "hero_walk_down_0")
    let buttonDirUp = ControllerButton(imageNamed: "button_dir_up_0",
        position: CGPoint(x: 100, y: 150))
        
    let buttonDirLeft = ControllerButton(imageNamed: "button_dir_left_0",
        position: CGPoint(x:50, y: 100))
    
    let buttonDirDown = ControllerButton(imageNamed: "button_dir_down_0",
        position: CGPoint(x: 100, y: 50))
    
    let buttonDirRight = ControllerButton(imageNamed: "button_dir_right_0",
        position: CGPoint(x:150, y: 100))
    
    var pressedButtons = [ControllerButton]()
    
    override func didMoveToView(view: SKView) {
        
        Settings.sharedInstance.virtualPad = false
        
        hero.texture?.filteringMode = .Nearest
        hero.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        hero.setScale(2.0)
        self.addChild(hero)
        self.addChild(buttonDirUp)
        self.addChild(buttonDirLeft)
        self.addChild(buttonDirDown)
        self.addChild(buttonDirRight)
        
        let l = 94.0 as CGFloat
        let x0 = 90.0 as CGFloat
        let y0 = 100.0 as CGFloat
        let angle = CGFloat(tan(M_PI / 3))
        
        if Settings.sharedInstance.virtualPad {
            self.addChild(buttonDirUp)
            // ..
            
            buttonDirRight.hitbox = {
                (location: CGPoint) -> Bool in
                return location.x - x0 > 0 && (abs(location.x - x0) * angle >= abs(location.y - y0))
                    && (location.x - x0) ** 2 + (location.y - y0) ** 2 <= l ** 2
            }
        }
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        for touch: AnyObject in touches {
            /*get location of the touch*/
            let location = touch.locationInNode(self)
            
            if Settings.sharedInstance.virtualPad {
                //for 4 buttons
                for button in [buttonDirUp, buttonDirLeft, buttonDirDown, buttonDirRight] {
                    if button.containsPoint(location) && find(pressedButtons, button) == nil {
                        pressedButtons.append(button)
                    }
                }
                for button in [buttonDirUp, buttonDirLeft, buttonDirDown, buttonDirRight] {
                    if find(pressedButtons, button) == nil {
                        button.alpha = 0.2
                    }
                    else {
                        button.alpha = 0.8
                    }
                }
            }
            else {
                destination = location
            }
        }
        if Settings.sharedInstance.virtualPad {
            
        }
    }
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            let previousLocation = touch.previousLocationInNode(self)
            
            if Settings.sharedInstance.virtualPad {
                for button in [buttonDirUp, buttonDirLeft, buttonDirDown, buttonDirRight] {
                    if button.containsPoint(previousLocation) && !button.containsPoint(location) {
                        // I remove it from the list
                        let index = find(pressedButtons, button)
                        if index != nil {
                            pressedButtons.removeAtIndex(index!)
                        }
                    }
                    else if !button.containsPoint(previousLocation) && button.containsPoint(location) && find(pressedButtons, button) == nil {
                        pressedButtons.append(button)
                    }
                }
            }
            else {
                destination = location
            }
        }
        
        if Settings.sharedInstance.virtualPad {
            for button in [buttonDirUp, buttonDirLeft, buttonDirDown, buttonDirRight] {
                if find(pressedButtons, button) == nil {
                    button.alpha = 0.2
                }
                else {
                    button.alpha = 0.8
                }
            }
        }
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        touchesEndedOrCancelled(touches, withEvent: event)
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            let previousLocation = touch.previousLocationInNode(self)
            
            for button in [buttonDirUp, buttonDirLeft, buttonDirDown, buttonDirRight] {
                if button.containsPoint(location) {
                    let index = find(pressedButtons, button)
                    if index != nil {
                        pressedButtons.removeAtIndex(index!)
                    }
                }
                else if (button.hitboxContainsPoint(previousLocation)) {
                    let index = find(pressedButtons, button)
                    if index != nil {
                        pressedButtons.removeAtIndex(index!)
                    }
                }
            }
        }
        for button in [buttonDirUp, buttonDirLeft, buttonDirDown, buttonDirRight] {
            if find(pressedButtons, button) == nil {
                button.alpha = 0.2
            }
            else {
                button.alpha = 0.8
            }
        }
    }
    
    override func touchesCancelled(touches: NSSet!, withEvent event: UIEvent!) {
        touchesEndedOrCancelled(touches, withEvent: event)
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            let previousLocation = touch.previousLocationInNode(self)
            
            for button in [buttonDirUp, buttonDirLeft, buttonDirDown, buttonDirRight] {
                if button.containsPoint(location) {
                    let index = find(pressedButtons, button)
                    if index != nil {
                        pressedButtons.removeAtIndex(index!)
                    }
                }
                else if (button.hitboxContainsPoint(previousLocation)) {
                    let index = find(pressedButtons, button)
                    if index != nil {
                        pressedButtons.removeAtIndex(index!)
                    }
                }
            }
        }
        for button in [buttonDirUp, buttonDirLeft, buttonDirDown, buttonDirRight] {
            if find(pressedButtons, button) == nil {
                button.alpha = 0.2
            }
            else {
                button.alpha = 0.8
            }
        }
    }
    
    func touchesEndedOrCancelled(touches: NSSet, withEvent event: UIEvent) {
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            let previousLocation = touch.previousLocationInNode(self)
            
            if Settings.sharedInstance.virtualPad {
                for button in [buttonDirUp, buttonDirLeft, buttonDirDown, buttonDirRight] {
                    
                }
            }
            else {
                destination = nil
            }
        }
        if Settings.sharedInstance.virtualPad {
            for button in [buttonDirUp, buttonDirLeft, buttonDirDown, buttonDirRight] {
                
            }
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        var walkingSpeed: CGFloat = 2.0
        
        if Settings.sharedInstance.virtualPad {
            if pressedButtons.count == 2 {
                walkingSpeed = walkingSpeed / sqrt(2.0)
            }
            if (find(pressedButtons, buttonDirUp) != nil) {
                hero.position.y += walkingSpeed
            }
            if (find(pressedButtons, buttonDirDown) != nil) {
                hero.position.y -= walkingSpeed
            }
            if (find(pressedButtons, buttonDirLeft) != nil) {
                hero.position.x -= walkingSpeed
            }
            if (find(pressedButtons, buttonDirRight) != nil) {
                hero.position.x -= walkingSpeed
            }
        }
        else {
            if destination == nil {
                return
            }
            if abs(destination.x - hero.frame.midX) < 4 && abs(destination.y - hero.frame.midY) < 4 {
                return
            }
            
            let direction = CGPoint(
                x: destination.x - hero.frame.midX,
                y: destination.y - hero.frame.midY
            )
            // Pythagoras FTW!
            let normalizedDirection = CGPoint(
                x: direction.x / (sqrt(direction.x ** 2 + direction.y ** 2)),
                y: direction.y / (sqrt(direction.x ** 2 + direction.y ** 2))
            )
            
            hero.position.x += normalizedDirection.x * walkingSpeed
            hero.position.y += normalizedDirection.y * walkingSpeed
        }
    }
}

//
//  BlockTypes.swift
//  KeyboardTest
//
//  Created by Thomas Abend on 11/20/15.
//  Copyright © 2015 com.hopscotch. All rights reserved.
//

import Foundation
import UIKit

enum EventOperator {
    
}


enum BlockType {
    
    case Start, Tap, IsTouching,
    Hold, TiltRight, TiltLeft, TiltUp, TiltDown,
    LoudNoise, Shake, Bump,
    SwipeRight, SwipeLeft, SwipeUp, SwipeDown, EnterTheWorld
    
    
    var colorForBlockType: UIColor {
        switch self {
            case
            .Start,
            .Tap,
            .IsTouching,
            .Hold,
            .TiltRight,
            .TiltLeft,
            .TiltUp,
            .TiltDown,
            .LoudNoise,
            .Shake,
            .Bump,
            .SwipeRight,
            .SwipeLeft,
            .SwipeUp,
            .SwipeDown,
            .EnterTheWorld:
                return UIColor.redColor()
            default:
                return UIColor.blackColor()
        }

    }

}
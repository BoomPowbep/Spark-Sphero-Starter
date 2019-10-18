//
//  MyMove.swift
//  SparkPerso
//
//  Created by Mickaël Debalme on 18/10/2019.
//  Copyright © 2019 AlbanPerli. All rights reserved.
//

import Foundation

class MyMove {
    var durationInSec: Double
    var speed: Double
    enum Direction {
        case front,back,rotateLeft,rotateRight,up,down,translateLeft,translateRight, none
    }
    var direction:Direction
    var breakDurationInSec: Double // Pause duration after movement
    var description:String {
        get {
            return "Move \(direction) during \(durationInSec)s at speed \(speed)"
        }
    }
    
    init(duration:Double, speed:Double, direction:Direction, breakDuration:Double) {
        self.durationInSec = duration
        self.speed = speed
        self.direction = direction
        self.breakDurationInSec = breakDuration
    }
}

class ForwardMove:MyMove {
     init(duration:Double, speed:Double, breakDuration:Double) {
        super.init(duration:duration, speed: speed, direction:.front, breakDuration:breakDuration)
    }
}

class BackwardsMove:MyMove {
     init(duration:Double, speed:Double, breakDuration:Double) {
        super.init(duration:duration, speed: speed, direction:.back, breakDuration:breakDuration)
    }
}

class RightRotationMove:MyMove {
     init(duration:Double, speed:Double, breakDuration:Double) {
        super.init(duration:duration, speed: speed, direction:.rotateRight, breakDuration:breakDuration)
    }
}

class RightRotation90Move:MyMove {
     init(speed:Double, breakDuration:Double) {
        super.init(duration:7, speed: speed, direction:.rotateRight, breakDuration:breakDuration)
    }
}

class LeftRotationMove:MyMove {
     init(duration:Double, speed:Double, breakDuration:Double) {
        super.init(duration:duration, speed: speed, direction:.rotateLeft, breakDuration:breakDuration)
    }
}

class LeftRotation90Move:MyMove {
     init(speed:Double, breakDuration:Double) {
        super.init(duration:7, speed: speed, direction:.rotateLeft, breakDuration:breakDuration)
    }
}

class RightTranslationMove:MyMove {
     init(duration:Double, speed:Double, breakDuration:Double) {
        super.init(duration:duration, speed: speed, direction:.translateRight, breakDuration:breakDuration)
    }
}

class LeftTranslationMove:MyMove {
     init(duration:Double, speed:Double, breakDuration:Double) {
        super.init(duration:duration, speed: speed, direction:.translateLeft, breakDuration:breakDuration)
    }
}

class UpMove:MyMove {
     init(duration:Double, speed:Double, breakDuration:Double) {
        super.init(duration:duration, speed: speed, direction:.up, breakDuration:breakDuration)
    }
}

class DownMove:MyMove {
    init(duration:Double, speed:Double, breakDuration:Double) {
        super.init(duration:duration, speed: speed, direction:.down, breakDuration:breakDuration)
    }
}

class Stop:MyMove {
    init() {
        super.init(duration:1, speed: 0, direction:.none, breakDuration:0.0)
    }
}

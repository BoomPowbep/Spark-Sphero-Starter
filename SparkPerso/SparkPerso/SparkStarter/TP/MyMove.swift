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
    enum Direction {
        case front,back,rotateLeft,rotateRight,up,down,translateLeft,translateRight, none
    }
    var direction:Direction
    var breakDurationInSec: Double // Pause duration after movement
    var description:String {
        get {
            return "Move \(direction) during \(durationInSec)s"
        }
    }
    
    init(duration:Double, direction:Direction, breakDuration:Double) {
        self.durationInSec = duration
        self.direction = direction
        self.breakDurationInSec = breakDuration
    }
}

class ForwardMove:MyMove {
     init(duration:Double, breakDuration:Double) {
        super.init(duration:duration, direction:.front, breakDuration:breakDuration)
    }
}

class BackwardsMove:MyMove {
     init(duration:Double, breakDuration:Double) {
        super.init(duration:duration, direction:.back, breakDuration:breakDuration)
    }
}

class RightRotationMove:MyMove {
     init(duration:Double, breakDuration:Double) {
        super.init(duration:duration, direction:.rotateRight, breakDuration:breakDuration)
    }
}

class RightRotation90Move:MyMove {
     init(breakDuration:Double) {
        super.init(duration:10, direction:.rotateRight, breakDuration:breakDuration)
    }
}

class LeftRotationMove:MyMove {
     init(duration:Double, breakDuration:Double) {
        super.init(duration:duration, direction:.rotateLeft, breakDuration:breakDuration)
    }
}

class LeftRotation90Move:MyMove {
     init(breakDuration:Double) {
        super.init(duration:10, direction:.rotateLeft, breakDuration:breakDuration)
    }
}

class RightTranslationMove:MyMove {
     init(duration:Double, breakDuration:Double) {
        super.init(duration:duration, direction:.translateRight, breakDuration:breakDuration)
    }
}

class LeftTranslationMove:MyMove {
     init(duration:Double, breakDuration:Double) {
        super.init(duration:duration, direction:.translateLeft, breakDuration:breakDuration)
    }
}

class UpMove:MyMove {
     init(duration:Double, breakDuration:Double) {
        super.init(duration:duration, direction:.up, breakDuration:breakDuration)
    }
}

class DownMove:MyMove {
     init(duration:Double, breakDuration:Double) {
        super.init(duration:duration, direction:.down, breakDuration:breakDuration)
    }
}

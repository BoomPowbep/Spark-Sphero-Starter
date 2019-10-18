//
//  MyMoveSpheroSphero.swift
//  SparkPerso
//
//  Created by Mickaël Debalme on 18/10/2019.
//  Copyright © 2019 AlbanPerli. All rights reserved.
//

import Foundation

class MyMoveSphero {
    var durationInSec: Double
    var speed: Double
    var heading:Double
    
    var description:String {
        get {
            return "Move \(heading) during \(durationInSec)s at speed \(speed)"
        }
    }
    
    init(duration:Double, speed:Double, heading:Double) {
        self.durationInSec = duration
        self.speed = speed
        self.heading = heading
    }
}

class SpheroMove:MyMoveSphero {
    override init(duration:Double, speed:Double, heading:Double) {
        super.init(duration:duration, speed:speed, heading:heading)
    }
}

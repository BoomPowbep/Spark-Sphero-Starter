//
//  MyMove.swift
//  SparkPerso
//
//  Created by Mickaël Debalme on 18/10/2019.
//  Copyright © 2019 AlbanPerli. All rights reserved.
//

import Foundation
import UIKit
import VideoPreviewer
import ImageDetect

class MyMove {
    var durationInSec: Double
    var speed: Double
    enum Direction {
        case front,back,rotateLeft,rotateRight,up,down,translateLeft,translateRight, none, cameraFront, cameraDown, takeOff, land, takePhoto
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

class CameraFront:MyMove {
    init() {
        super.init(duration: 1, speed: 0, direction: .cameraFront, breakDuration: 0)
    }
}

class CameraDown:MyMove {
    init() {
        super.init(duration: 1, speed: 0, direction: .cameraDown, breakDuration: 0)
    }
}

class TakeOff:MyMove {
    init() {
        super.init(duration: 5, speed: 0, direction: .takeOff, breakDuration: 1)
    }
}

class Land:MyMove {
    init() {
        super.init(duration: 10, speed: 0, direction: .land, breakDuration: 1)
    }
}

class TakePhoto:MyMove {
    init(photoView:UIImageView) {
        super.init(duration: 1, speed: 0, direction: .takePhoto, breakDuration: 0)
        
        let prev1 = VideoPreviewer()
        
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            prev1?.snapshotThumnnail { (image) in
                
                if let img = image {
                    print("\n\n")
                    print(img.size)
                    print("\n\n")
                    
                    img.detector.crop(type: DetectionType.face) { result in
                        DispatchQueue.main.async { [weak self] in
                            switch result {
                            case .success(let croppedImages):
                                // When the `Vision` successfully find type of object you set and successfuly crops it.
                                photoView.image = croppedImages.first
                            case .notFound:
                                // When the image doesn't contain any type of object you did set, `result` will be `.notFound`.
                                print("😡 grrrrr")
                            case .failure(let error):
                                // When the any error occured, `result` will be `failure`.
                                print("😡", error.localizedDescription)
                            }
                        }
                    }
                    
                }
            }
        }
    }
}

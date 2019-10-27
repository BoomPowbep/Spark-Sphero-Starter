//
//  SparkMovementManager.swift
//  SparkPerso
//
//  Created by Mickaël Debalme on 27/10/2019.
//  Copyright © 2019 AlbanPerli. All rights reserved.
//

import UIKit
import DJISDK

class SparkMovementManager : MovementManager {
    
    // MARK: - Declarations, initializations
    
    override init(pLogsTextView: UITextView) {
        super.init(pLogsTextView: pLogsTextView)
     
        self.displacement = 0.3
    }
    
    override func move(pMove: MyMove) {
        super.move(pMove: pMove)
        self.stop() // IMPORTANT: ERASE ALL VALUES BEFORE ASSIGNING NEW MOVE
        if let mySpark = DJISDKManager.product() as? DJIAircraft {
            switch(pMove.direction) {
            case .front :
                mySpark.mobileRemoteController?.rightStickVertical = Float(pMove.speed)
            case .back:
                mySpark.mobileRemoteController?.rightStickVertical = Float(-pMove.speed)
            case .rotateLeft:
                mySpark.mobileRemoteController?.leftStickHorizontal = Float(-pMove.speed)
            case .rotateRight:
                mySpark.mobileRemoteController?.leftStickHorizontal = Float(pMove.speed)
            case .up:
                mySpark.mobileRemoteController?.leftStickVertical = Float(pMove.speed)
            case .down:
                mySpark.mobileRemoteController?.leftStickVertical = Float(-pMove.speed)
            case .translateLeft:
                mySpark.mobileRemoteController?.rightStickHorizontal = Float(-pMove.speed)
            case .translateRight:
                mySpark.mobileRemoteController?.rightStickHorizontal = Float(pMove.speed)
            case .none:
                stop()
            }
        }
    }
    
    override func stop() {
        super.stop()
        
        if let mySpark = DJISDKManager.product() as? DJIAircraft {
            mySpark.mobileRemoteController?.leftStickVertical = 0.0
            mySpark.mobileRemoteController?.leftStickHorizontal = 0.0
            mySpark.mobileRemoteController?.rightStickHorizontal = 0.0
            mySpark.mobileRemoteController?.rightStickVertical = 0.0
        }
    }
}

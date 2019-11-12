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
    
    override init(pLogsTextView: UITextView? = nil) {
        super.init(pLogsTextView: pLogsTextView!)
        
        self.displacement = 0.3
        
        GimbalManager.shared.setup(withDuration: 1.0, defaultPitch: -28.0)
    }
    
    override func doMove(pMove: MyMove) {
        super.doMove(pMove: pMove)
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
            case .cameraFront:
                GimbalManager.shared.lookFront()
            case .cameraDown:
                GimbalManager.shared.lookUnder()
            case .takeOff:
                if let mySpark = DJISDKManager.product() as? DJIAircraft {
                    if let flightController = mySpark.flightController {
                        flightController.startTakeoff(completion: { (err) in
                            print(err.debugDescription)
                        })
                    }
                }
            case .land:
                if let mySpark = DJISDKManager.product() as? DJIAircraft {
                    if let flightController = mySpark.flightController {
                        flightController.startLanding(completion: { (err) in
                            print(err.debugDescription)
                        })
                    }
                }
            case .takePhoto:
                print("photo")
            }
        }
    }
    
    override func singleMove(pMove: MyMove) {
        super.singleMove(pMove: pMove)
        self.stop() // IMPORTANT: ERASE ALL VALUES BEFORE ASSIGNING NEW MOVE
        
        self.doMove(pMove: pMove)
    }
    
    func ddddoubleMove(pMoves: [MyMove]) {
        self.stop() // IMPORTANT: ERASE ALL VALUES BEFORE ASSIGNING NEW MOVE
        
        //        for move in pMoves {
        //            self.doMove(pMove: move)
        //        }
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

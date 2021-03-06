//
//  SPRKToy.swift
//  SpheroSDK
//
//  Created by Jordan Hesse on 2017-04-26.
//  Copyright © 2018 Sphero Inc. All rights reserved.
//

public class SPRKToy: SpheroV1Toy {
    
    override class var descriptor: String { return "SK-" }
    
    public override var batteryLevel: Double? {
        get {
            guard let batteryVoltage = core.batteryVoltage else { return nil }
            return (batteryVoltage - 6.5) / (7.8 - 6.5)
        }
    }
    
}

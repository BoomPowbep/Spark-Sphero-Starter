////
////  GenericMovementManager.swift
////  SparkPerso
////
////  Created by Mickaël Debalme on 18/10/2019.
////  Copyright © 2019 AlbanPerli. All rights reserved.
////
//
//import Foundation
//
//class GenericMovementManager {
//
//    private var mSequence:[MyMove] = []
//    private var mSequenceIndex:Int = 0
//    private var mSequenceRunning:Bool = false
//    private let displacement:Float = 0.4
//
//    func startSequence() {
//        if(mSequence.count > 0) {
//            mSequenceRunning = true
//            startButton.isEnabled = false
//            iterateSequence()
//        }
//    }
//
//    func iterateSequence() {
//        if(self.mSequenceRunning) {
//            // Move drone
//            log(textView: logsTextView, message: "[DOING] " + self.mSequence[self.mSequenceIndex].description)
//            move(direction: mSequence[mSequenceIndex].direction)
//
//            delay(mSequence[mSequenceIndex].durationInSec) {
//                // STOP drone
//                log(textView: self.logsTextView, message: "[END OF ITERATION]\n")
//                self.stop()
//
//                // Continue if sequence is not cancelled and next array iteration exists
//                if(self.mSequenceRunning && self.mSequence.indices.contains(self.mSequenceIndex+1)) {
//
//                    // Do a break if necessary
//                    delay(self.mSequence[self.mSequenceIndex].breakDurationInSec) {
//                        self.mSequenceIndex += 1
//                        self.iterateSequence() // Loop
//                    }
//                }
//                else { // End of sequence, reset parameters
//                    self.resetSequence()
//                }
//            }
//        }
//        else {
//            self.resetSequence()
//        }
//    }
//
//    func resetSequence() {
//        log(textView: self.logsTextView, message: "[END OF SEQUENCE]")
//        self.mSequenceRunning = false
//        self.mSequenceIndex = 0
//        startButton.isEnabled = true
//    }
//
//    
//}
//
//class SparkMovementManager:GenericMovementManager {
//
//}
//
//class SpheroMovementManager:GenericMovementManager {
//
//}

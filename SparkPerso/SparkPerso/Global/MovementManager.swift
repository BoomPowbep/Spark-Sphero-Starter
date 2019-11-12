//
//  MovementManager.swift
//  SparkPerso
//
//  Created by Mickaël Debalme on 27/10/2019.
//  Copyright © 2019 AlbanPerli. All rights reserved.
//

import UIKit
import DJISDK

class MovementManager {
    
    // MARK: - Declarations, initializations
    
    var mSequence:[MyMove] = []
    
    var mSequenceIndex:Int = 0
    
    var mSequenceRunning:Bool = false
    
    var displacement:Float = 0.3
     
    let logsTextView: UITextView!
    
    init(pLogsTextView: UITextView) {
        logsTextView = pLogsTextView
    }
    
    // MARK: - Sequencer
    
    func startSequence() {
        if(mSequence.count > 0) {
            mSequenceRunning = true
            iterateSequence()
        }
        else {
            log(textView: logsTextView, message: "\n[->][X] Empty sequence. Cancelling.\n")
        }
    }
    
    func iterateSequence() {
           if(self.mSequenceRunning) {
               // Move drone
               singleMove(pMove: mSequence[mSequenceIndex])
               log(textView: logsTextView, message: "[DOING] " + self.mSequence[self.mSequenceIndex].description)
               
               delay(mSequence[mSequenceIndex].durationInSec) {
                   // STOP
                   self.stop()
                   if(self.mSequenceRunning) {
                       log(textView: self.logsTextView, message: "[END OF ITERATION]\n")
                   }
                   
                   // Continue if sequence is not cancelled and next array iteration exists
                   if(self.mSequenceRunning && self.mSequence.indices.contains(self.mSequenceIndex+1)) {
                       
                       // Do a break if necessary
                       delay(self.mSequence[self.mSequenceIndex].breakDurationInSec) {
                           self.mSequenceIndex += 1
                           self.iterateSequence() // Loop
                       }
                   }
                   else { // End of sequence, reset parameters
                       self.resetSequence()
                   }
               }
           }
           else {
               self.resetSequence()
           }
       }
    
    func resetSequence() {
        stop()
        if(mSequenceRunning) {
            log(textView: self.logsTextView, message: "[END OF SEQUENCE]")
        }
        self.mSequenceRunning = false
        self.mSequenceIndex = 0
    }
    
    func sequenceDescription() -> String {
        var fullDescription = "\n"
        
        for move in mSequence {
            fullDescription += move.description + "\n"
        }
        return fullDescription
    }
    
    // MARK: - Movement
    
    func doMove(pMove:MyMove) {
//        stop() // IMPORTANT: ERASE ALL VALUES BEFORE ASSIGNING NEW MOVE
    }
    
    func singleMove(pMove: MyMove) {
        
    }
    
    func stop() {
        
    }
}

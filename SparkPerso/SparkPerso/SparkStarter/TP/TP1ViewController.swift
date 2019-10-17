//
//  TP1ViewController.swift
//  SparkPerso
//
//  Created by Mickaël Debalme on 17/10/2019.
//  Copyright © 2019 AlbanPerli. All rights reserved.
//

import UIKit
import DJISDK

class TP1ViewController: UIViewController {
    
    struct MyMove{
        var durationInSec: Double
        enum Direction {
            case front,back,rotateLeft,rotateRight,up,down,translateLeft,translateRight
        }
        var direction:Direction
        var breakDurationInSec: Double
        var description:String {
            get {
                return "Move \(direction) during \(durationInSec)s"
            }
        }
    }
    
    private var mSequence:[MyMove] = []
    private var mSequenceIndex:Int = 0
    private var mSequenceRunning:Bool = false
    private let displacement:Float = 0.4
    
    @IBOutlet weak var logsTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Init sequence elements
        let forward = MyMove(durationInSec: 1, direction: .front, breakDurationInSec: 1)
        let backwards = MyMove(durationInSec: 1, direction: .back, breakDurationInSec: 1)
        let rightYaw = MyMove(durationInSec: 1, direction: .rotateRight, breakDurationInSec: 1)
        let leftYaw = MyMove(durationInSec: 1, direction: .rotateLeft, breakDurationInSec: 1)
        let rightRoll = MyMove(durationInSec: 1, direction: .translateRight, breakDurationInSec: 1)
        let leftRoll = MyMove(durationInSec: 1, direction: .translateLeft, breakDurationInSec: 1)
        let up = MyMove(durationInSec: 1, direction: .up, breakDurationInSec: 1)
        let down = MyMove(durationInSec: 1, direction: .down, breakDurationInSec: 1)
        
        // Init sequence array - Directions test sequence
        mSequence = [forward, backwards, rightYaw, leftYaw, rightRoll, leftRoll, up, down]
        
        // Init sequence array - Square sequence
//        mSequence = [forward, rightYaw, forward, rightYaw, forward, rightYaw, forward, rightYaw]
    }
    
    func startSequence() {
        if(mSequence.count > 0) {
            mSequenceRunning = true
            iterateSequence()
        }
    }
    
    func iterateSequence() {
        if(self.mSequenceRunning) {
            // Move drone
            log(textView: logsTextView, message: "[DOING] " + self.mSequence[self.mSequenceIndex].description)
            move(direction: mSequence[mSequenceIndex].direction)
            
            delay(mSequence[mSequenceIndex].durationInSec) {
                // STOP drone
                log(textView: self.logsTextView, message: "[END OF ITERATION]\n")
                self.stop()
                
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
    
    func move(direction:MyMove.Direction) {
        if let mySpark = DJISDKManager.product() as? DJIAircraft {
            switch(direction) {
            case .front :
                mySpark.mobileRemoteController?.rightStickVertical = displacement
            case .back:
                mySpark.mobileRemoteController?.rightStickVertical = -displacement
            case .rotateLeft:
                mySpark.mobileRemoteController?.leftStickHorizontal = displacement
            case .rotateRight:
                mySpark.mobileRemoteController?.leftStickHorizontal = -displacement
            case .up:
                mySpark.mobileRemoteController?.leftStickVertical = displacement
            case .down:
                mySpark.mobileRemoteController?.leftStickVertical = -displacement
            case .translateLeft:
                mySpark.mobileRemoteController?.rightStickHorizontal = displacement
            case .translateRight:
                mySpark.mobileRemoteController?.rightStickHorizontal = displacement
            }
        }
    }
    
    func resetSequence() {
        log(textView: self.logsTextView, message: "[END OF SEQUENCE]")
        self.mSequenceRunning = false
        self.mSequenceIndex = 0
    }
    
    func stop() {
        if let mySpark = DJISDKManager.product() as? DJIAircraft {
            mySpark.mobileRemoteController?.leftStickVertical = 0.0
            mySpark.mobileRemoteController?.leftStickHorizontal = 0.0
            mySpark.mobileRemoteController?.rightStickHorizontal = 0.0
            mySpark.mobileRemoteController?.rightStickVertical = 0.0
        }
    }
    
    @IBAction func startButtonClicked(_ sender: Any) {
        
        log(textView: logsTextView, message: "\n[->] START button clicked\n")
        startSequence()
    }
    
    @IBAction func stopButtonClicked(_ sender: Any) {
        
        log(textView: logsTextView, message: "\n[X] STOP button clicked")
        mSequenceRunning = false
        stop()
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

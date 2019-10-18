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
    
    private var soundManager:SoundManager = SoundManager()
    
    private var mSequence:[MyMove] = []
    private var mSequenceIndex:Int = 0
    private var mSequenceRunning:Bool = false
    private let displacement:Float = 0.4
    
    @IBOutlet weak var logsTextView: UITextView!
    
    @IBOutlet weak var startButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Init sequence array - Directions test sequence
        //        mSequence = [forward, backwards, rightYaw, leftYaw, rightRoll, leftRoll, up, down]
        mSequence = [
            RightRotation90Move(breakDuration: 1),
            LeftRotation90Move(breakDuration: 1)
        ]
        
        // Init sequence array - Square sequence
        //        mSequence = [forward, rightYaw, forward, rightYaw, forward, rightYaw, forward, rightYaw]
    }
    
    // MARK: - Sequencer
    
    func startSequence() {
        if(mSequence.count > 0) {
            mSequenceRunning = true
            startButton.isEnabled = false
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
    
    func resetSequence() {
        log(textView: self.logsTextView, message: "[END OF SEQUENCE]")
        self.mSequenceRunning = false
        self.mSequenceIndex = 0
        startButton.isEnabled = true
    }
    
    // MARK: - Drone Movement
    
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
            case .none:
                stop()
            }
        }
    }
    
    func stop() {
        if let mySpark = DJISDKManager.product() as? DJIAircraft {
            mySpark.mobileRemoteController?.leftStickVertical = 0.0
            mySpark.mobileRemoteController?.leftStickHorizontal = 0.0
            mySpark.mobileRemoteController?.rightStickHorizontal = 0.0
            mySpark.mobileRemoteController?.rightStickVertical = 0.0
        }
    }
    
    // MARK: - Buttons handlers
    
    @IBAction func startButtonClicked(_ sender: Any) {
        
        log(textView: logsTextView, message: "\n[->] START button clicked\n")
        
        // Check if sequence is already running
        if(mSequenceRunning) {
            log(textView: logsTextView, message: "\n[WARNING] Sequence already running! Cancelled.\n")
        }
        else {
            startSequence()
        }
        
        soundManager.playSound(sound: SoundManager.Sound.OUUUU)
    }
    
    @IBAction func stopButtonClicked(_ sender: Any) {
        
        log(textView: logsTextView, message: "\n[X] STOP button clicked")
        
        mSequenceRunning = false
        stop()
        
        soundManager.playSound(sound: SoundManager.Sound.AAOUUUU)
    }
}

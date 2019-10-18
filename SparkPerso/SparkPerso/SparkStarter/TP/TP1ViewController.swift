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
    
    private var mSequence:[MyMove] = [] {
        didSet {
            DispatchQueue.main.async {
                log(textView: self.logsTextView, message: self.sequenceDescription())
            }
        }
    }
    private var mSequenceIndex:Int = 0
    private var mSequenceRunning:Bool = false
    private let displacement:Float = 0.3
    
    @IBOutlet weak var logsTextView: UITextView!
    
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var frontButton: UIButton!
    @IBOutlet weak var rotateLeftButton: UIButton!
    @IBOutlet weak var rotateRight: UIButton!
    @IBOutlet weak var displaySequenceButton: UIButton!
    @IBOutlet weak var clearSequenceButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Init sequence array - Directions test sequence
        //        mSequence = [forward, backwards, rightYaw, leftYaw, rightRoll, leftRoll, up, down]
        //        mSequence = [
        //            RightRotation90Move(breakDuration: 1),
        //            ForwardMove(duration: 1, breakDuration: 1),
        //            LeftRotation90Move(breakDuration: 1)
        //        ]
        
        mSequence = []
        
        // Init sequence array - Square sequence
        //        mSequence = [forward, rightYaw, forward, rightYaw, forward, rightYaw, forward, rightYaw]
    }
    
    // MARK: - Sequencer
    
    func startSequence() {
        if(mSequence.count > 0) {
            mSequenceRunning = true
            startButton.isEnabled = false
            displaySequenceButton.isEnabled = false
            clearSequenceButton.isEnabled = false
            iterateSequence()
        }
        else {
            displaySequenceButton.isEnabled = true
            clearSequenceButton.isEnabled = true
            log(textView: logsTextView, message: "\n[->][X] Empty sequence. Cancelling.\n")
        }
    }
    
    func iterateSequence() {
        if(self.mSequenceRunning) {
            // Move drone
            move(direction: mSequence[mSequenceIndex].direction)
            log(textView: logsTextView, message: "[DOING] " + self.mSequence[self.mSequenceIndex].description)
            
            delay(mSequence[mSequenceIndex].durationInSec) {
                // STOP drone
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
        startButton.isEnabled = true
    }
    
    func sequenceDescription() -> String {
        var fullDescription = "\n"
        
        for move in mSequence {
            fullDescription += move.description + "\n"
        }
        return fullDescription
    }
    
    // MARK: - Drone Movement
    
    func move(direction:MyMove.Direction) {
        if let mySpark = DJISDKManager.product() as? DJIAircraft {
            stop() // IMPORTANT: ERASE ALL VALUES BEFORE ASSIGNING NEW MOVE
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
        
        log(textView: logsTextView, message: "\n[X] STOP button clicked\n[SEQUENCE CANCELLED]")
        
        mSequenceRunning = false
        stop()
        startButton.isEnabled = true
        
        displaySequenceButton.isEnabled = true
        clearSequenceButton.isEnabled = true
        
        soundManager.playSound(sound: SoundManager.Sound.AAOUUUU)
    }
    
    
    @IBAction func displaySequenceButtonClicked(_ sender: Any) {
        log(textView: logsTextView, message: sequenceDescription())
    }
    
    @IBAction func clearSequenceButtonClicked(_ sender: Any) {
        mSequenceRunning = false
        mSequence = []
//        startButton.isEnabled = false
    }
    
    @IBAction func moveFrontButtonClicked(_ sender: Any) {
        mSequence.append(ForwardMove(duration: 1, breakDuration: 1))
//        startButton.isEnabled = true
    }
    
    @IBAction func rotateLeftButtonClicked(_ sender: Any) {
        mSequence.append(LeftRotation90Move(breakDuration: 1))
//        startButton.isEnabled = true
    }
    
    @IBAction func rotateRightButtonClicked(_ sender: Any) {
        mSequence.append(RightRotation90Move(breakDuration: 1))
//        startButton.isEnabled = true
    }
}

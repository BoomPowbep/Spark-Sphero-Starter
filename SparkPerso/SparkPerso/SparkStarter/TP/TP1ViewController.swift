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

    @IBOutlet weak var logsTextView: UITextView!
    
    private var movementManager:SparkMovementManager! = nil
    
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var frontButton: UIButton!
    @IBOutlet weak var rotateLeftButton: UIButton!
    @IBOutlet weak var rotateRight: UIButton!
    @IBOutlet weak var displaySequenceButton: UIButton!
    @IBOutlet weak var clearSequenceButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movementManager = SparkMovementManager(pLogsTextView: logsTextView)
    }
    
    // MARK: - Buttons handlers
    
    @IBAction func startButtonClicked(_ sender: Any) {
        
        log(textView: logsTextView, message: "[->] START button clicked\n")
        
        // Check if sequence is already running
        if(movementManager.mSequenceRunning) {
            log(textView: logsTextView, message: "\n[WARNING] Sequence already running! Cancelled.\n")
        }
        else {
            movementManager.startSequence()
        }
        
//        soundManager.playSound(sound: SoundManager.Sound.OUUUU)
    }
    
    @IBAction func stopButtonClicked(_ sender: Any) {
        
        log(textView: logsTextView, message: "\n[X] STOP button clicked\n[SEQUENCE CANCELLED]")
        
        movementManager.mSequenceRunning = false
        movementManager.stop()
        startButton.isEnabled = true
        
//        soundManager.playSound(sound: SoundManager.Sound.AAOUUUU)
    }
    
    
    @IBAction func displaySequenceButtonClicked(_ sender: Any) {
        log(textView: logsTextView, message: movementManager.sequenceDescription())
    }
    
    @IBAction func clearSequenceButtonClicked(_ sender: Any) {
        movementManager.mSequenceRunning = false
        movementManager.mSequence = []
        log(textView: self.logsTextView, message: "SEQUENCE CLEARED")
    }
    
    @IBAction func moveFrontButtonClicked(_ sender: Any) {
        self.askForDurationAndSpeed { (speed, duration) in
            self.movementManager.mSequence.append(ForwardMove(duration: duration, speed:speed, breakDuration: 1))
        }
    }
    
    @IBAction func rotateLeftButtonClicked(_ sender: Any) {
        self.askForDurationAndSpeed { (speed, duration) in
            self.movementManager.mSequence.append(LeftRotationMove(duration: 3, speed:speed, breakDuration: 1))
        }
        
    }
    
    @IBAction func rotateRightButtonClicked(_ sender: Any) {
        self.askForDurationAndSpeed { (speed, duration) in
            self.movementManager.mSequence.append(RightRotationMove(duration: 3, speed:speed, breakDuration: 1))
        }
        
    }
}

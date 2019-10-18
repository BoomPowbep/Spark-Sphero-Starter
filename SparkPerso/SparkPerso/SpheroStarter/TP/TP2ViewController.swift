//
//  TP2ViewController.swift
//  SparkPerso
//
//  Created by Mickaël Debalme on 18/10/2019.
//  Copyright © 2019 AlbanPerli. All rights reserved.
//

import UIKit

class TP2ViewController: UIViewController {

    private var soundManager:SoundManager = SoundManager()
    
    private var mSequence:[MyMoveSphero] = [] {
        didSet {
            DispatchQueue.main.async {
                log(textView: self.logsTextView, message: self.sequenceDescription())
            }
        }
    }
    
    private var mSequenceIndex:Int = 0
    private var mSequenceRunning:Bool = false
    private let displacement:Float = 0.3
    
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var displaySequenceButton: UIButton!
    @IBOutlet weak var clearSequenceButton: UIButton!
    @IBOutlet weak var logsTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mSequence = []
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
            move(move: mSequence[mSequenceIndex])
            log(textView: logsTextView, message: "[DOING] " + self.mSequence[self.mSequenceIndex].description)
            
            delay(mSequence[mSequenceIndex].durationInSec) {
                // STOP drone
                self.stop()
                if(self.mSequenceRunning) {
                    log(textView: self.logsTextView, message: "[END OF ITERATION]\n")
                }
                
                // Continue if sequence is not cancelled and next array iteration exists
                if(self.mSequenceRunning && self.mSequence.indices.contains(self.mSequenceIndex+1)) {
                    
                    self.mSequenceIndex += 1
                    self.iterateSequence() // Loop
                    
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
        displaySequenceButton.isEnabled = true
        clearSequenceButton.isEnabled = true
    }
    
    func sequenceDescription() -> String {
        var fullDescription = "\n"
        
        for move in mSequence {
            fullDescription += move.description + "\n"
        }
        return fullDescription
    }
    
    // MARK: - Drone Movement
    
    func move(move:MyMoveSphero) {
        
            stop() // IMPORTANT: ERASE ALL VALUES BEFORE ASSIGNING NEW MOVE
            switch(move.heading) {
            case 90 :
                _ = SharedToyBox.instance.bolts.map{ $0.roll(heading: move.heading, speed: move.speed) }
            case 180:
                _ = SharedToyBox.instance.bolts.map{ $0.roll(heading: move.heading, speed: move.speed) }
            case 0:
                _ = SharedToyBox.instance.bolts.map{ $0.roll(heading: move.heading, speed: move.speed) }
            default:
                _ = SharedToyBox.instance.bolts.map{ $0.roll(heading: 0, speed: 0) }
        }
        
    }
    
    func stop() {
            
    }
    

    // MARK: - Buttons handlers
    @IBAction func onStartButtonClick(_ sender: Any) {
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
    @IBAction func onDisplaySequenceClick(_ sender: Any) {
        log(textView: logsTextView, message: sequenceDescription())
    }
    @IBAction func clearSequenceClick(_ sender: Any) {
        mSequenceRunning = false
                mSequence = []
        //        startButton.isEnabled = false
    }
    @IBAction func onStopButtonClick(_ sender: Any) {
        log(textView: logsTextView, message: "\n[X] STOP button clicked\n[SEQUENCE CANCELLED]")
        
        mSequenceRunning = false
        stop()
        startButton.isEnabled = true
        
        displaySequenceButton.isEnabled = true
        clearSequenceButton.isEnabled = true
        
        soundManager.playSound(sound: SoundManager.Sound.AAOUUUU)
    }
    
    
    
    
    
    
    
    @IBAction func onFrontButtonClick(_ sender: Any) {
        self.askForDurationSpeedAndHeading { (speed, duration, heading) in
            self.mSequence.append(SpheroMove(duration: duration, speed: speed, heading:heading))
        }
    }
    
    
    @IBAction func onRotateLeftButtonClick(_ sender: Any) {
        self.askForDurationSpeedAndHeading { (speed, duration, heading) in
            self.mSequence.append(SpheroMove(duration: duration, speed: speed, heading:heading))
        }
    }
    
    
    @IBAction func onRotateRightButtonClick(_ sender: Any) {
        self.askForDurationSpeedAndHeading { (speed, duration, heading) in
            self.mSequence.append(SpheroMove(duration: duration, speed: speed, heading:heading))
        }
    }
    
}

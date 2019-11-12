//
//  ExoViewController.swift
//  SparkPerso
//
//  Created by Mickaël Debalme on 11/11/2019.
//  Copyright © 2019 AlbanPerli. All rights reserved.
//

import UIKit

class ExoViewController: UIViewController {
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    @IBOutlet weak var logsTextView: UITextView!
    
    private var movementManager:SparkMovementManager! = nil
    
    private var isPlaying:Bool = false
    
    private var moves:[MyMove] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movementManager = SparkMovementManager(pLogsTextView: logsTextView)
        
        let speed:Double = 0.4
        
        moves.append(CameraFront())
        moves.append(TakePhoto(photoView: photoImageView))
        
//        moves.append(TakeOff())
//        moves.append(UpMove(duration: 1, speed: speed, breakDuration: 1))
//        moves.append(CameraDown())
//        moves.append(TakePhoto(photoView: photoImageView))
//        moves.append(CameraFront())
//        moves.append(BackwardsMove(duration: 2, speed: speed, breakDuration: 1))
//        moves.append(DownMove(duration: 2, speed: speed, breakDuration: 1))
//        moves.append(ForwardMove(duration: 2, speed: speed, breakDuration: 1))
//        moves.append(UpMove(duration: 1, speed: speed, breakDuration: 1))
//        moves.append(CameraDown())
//        moves.append(Land())
        
        movementManager.mSequence = moves
    }
    
    // MARK: - Navigation
    @IBAction func onStartButtonClick(_ sender: Any) {
        if(!isPlaying) {
            isPlaying = true
            print(" -> START Button Clicked")
            
            // Check if sequence is already running
            if(movementManager.mSequenceRunning) {
                log(textView: logsTextView, message: "\n[WARNING] Sequence already running! Cancelled.\n")
            }
            else {
                movementManager.startSequence()
            }
            
        }
        else {
            // Do nothing
            print(" -X START Button Clicked")
        }
    }
    
    @IBAction func onStopButtonClick(_ sender: Any) {
        isPlaying = false
        
        log(textView: logsTextView, message: "\n[X] STOP button clicked\n[SEQUENCE CANCELLED]")
        
        movementManager.mSequenceRunning = false
        movementManager.stop()
        
        print(" -> STOP Button Clicked")
    }
}

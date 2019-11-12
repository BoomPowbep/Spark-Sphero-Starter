//
//  ExoSpheroViewController.swift
//  SparkPerso
//
//  Created by Mickaël Debalme on 11/11/2019.
//  Copyright © 2019 AlbanPerli. All rights reserved.
//

import UIKit

class ExoSpheroViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        SharedToyBox.instance.bolt?.setStabilization(state: SetStabilization.State.on)
    }
    
    
    // MARK: - Buttons handlers
    @IBAction func onStartButtonClick(_ sender: Any) {
        
        for i in 0...3600 {
            _ = SharedToyBox.instance.bolt?.roll(heading: Double(i), speed: 150)
        }
         _ = SharedToyBox.instance.bolt?.stopRoll(heading: 0.0)
        
//        _ = SharedToyBox.instance.bolts.map{ $0.stopRoll(heading: currentHeading) }
        
    }
    
    @IBAction func onStopButtonClick(_ sender: Any) {
        _ = SharedToyBox.instance.bolt?.stopRoll(heading: 0.0)
    }
}

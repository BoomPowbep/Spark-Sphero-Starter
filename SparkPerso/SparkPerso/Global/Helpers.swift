//
//  Helpers.swift
//  SparkPerso
//
//  Created by Mickaël Debalme on 17/10/2019.
//  Copyright © 2019 AlbanPerli. All rights reserved.
//

import Foundation
import UIKit

func delay(_ delay:Double, closure:@escaping ()->()) {
    let when = DispatchTime.now() + delay
    DispatchQueue.main.asyncAfter(deadline: when, execute: closure)
}

// DRONE MAX SPEED = 1
// SPHERO MAX SPEED = 250
extension UIViewController {
    
    func askForDurationAndSpeed(callback:@escaping(Double,Double)->()) {
        let ac = UIAlertController(title: "Enter speed and duration", message: nil, preferredStyle: .alert)
        ac.addTextField { (txt) in
            txt.placeholder = "Speed"
        }
        ac.addTextField { (txt) in
            txt.placeholder = "Duration"
        }
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) { [unowned ac] _ in
            if let speedText = ac.textFields![0].text,
                let durationText = ac.textFields![1].text,
                let speed = Double(speedText),
                let duration = Double(durationText) {
                
                callback(speed, duration)
            }
        }
        
        ac.addAction(submitAction)
        
        present(ac, animated: true)
    }
    
    func askForDurationSpeedAndHeading(callback:@escaping(Double,Double,Double)->()) {
        let ac = UIAlertController(title: "Enter speed and duration", message: nil, preferredStyle: .alert)
        ac.addTextField { (txt) in
            txt.placeholder = "Speed"
        }
        ac.addTextField { (txt) in
            txt.placeholder = "Duration"
        }
        ac.addTextField { (txt) in
            txt.placeholder = "Heading"
        }
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) { [unowned ac] _ in
            if let speedText = ac.textFields![0].text,
                let durationText = ac.textFields![1].text,
                let headingText = ac.textFields![2].text,
                let speed = Double(speedText),
                let duration = Double(durationText),
                let heading = Double(headingText) {
                
                callback(speed, duration, heading)
            }
        }
        
        ac.addAction(submitAction)
        
        present(ac, animated: true)
    }
}

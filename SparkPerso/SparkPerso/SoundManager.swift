//
//  SoundManager.swift
//  SparkPerso
//
//  Created by Mickaël Debalme on 18/10/2019.
//  Copyright © 2019 AlbanPerli. All rights reserved.
//

import Foundation
import AVKit

class SoundManager {
    
    enum Sound {
        case AAOUUUU, OUUUU
    }
    
    func playSound(sound:Sound){
        var audioPlayer: AVAudioPlayer?
        let path  = Bundle.main.path(forResource: (sound == .OUUUU) ? "OUUUU.mp3" : "AAOUUUU.mp3", ofType: nil)!
        let url = URL(fileURLWithPath: path)
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        } catch {
            print("couldn't load the audio file")
        }
    }
}

//
//  AudioController.swift
//  Metronome
//
//  Created by Giovani Nascimento Pereira on 18/06/18.
//  Copyright © 2018 Giovani Nascimento Pereira. All rights reserved.
//

import Foundation
import AVFoundation

class AudioController {
    
    static var player: AVAudioPlayer?
    
    static func playLowBeep() {
        if let url = Bundle.main.url(forResource: "metronome_click", withExtension: "mp3") {
            startSong(url)
        } else {
            return
        }
    }
    
    static func playHighBeep() {
        if let url = Bundle.main.url(forResource: "metronome_loud", withExtension: "mp3") {
            startSong(url)
        } else {
            return
        }
    }
    
    private static func startSong(_ url: URL) {
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
            
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            
            guard let backgroundPlayer = player else { return }
            
            backgroundPlayer.volume = 0.8
            backgroundPlayer.numberOfLoops = 0
            backgroundPlayer.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
}

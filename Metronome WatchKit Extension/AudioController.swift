//
//  AudioController.swift
//  Metronome WatchKit Extension
//
//  Created by Giovani Nascimento Pereira on 18/06/18.
//  Copyright © 2018 Giovani Nascimento Pereira. All rights reserved.
//
//  Reference: https://stackoverflow.com/questions/39302699/how-can-i-play-a-custom-sound-in-watchos-3-that-will-playback-on-the-watch-speak
//

import Foundation
import AVFoundation


class AudioController {
    
    static var path = Bundle.main.path(forResource: "metronome_click", ofType: "mp3")
    static var _audioPlayer: AVAudioPlayerNode!
    static var _audioEngine: AVAudioEngine!
    
    class func playAudio() {
        if (_audioPlayer==nil) {
            _audioPlayer = AVAudioPlayerNode()
            _audioEngine = AVAudioEngine()
            _audioEngine.attach(_audioPlayer)
            
            let stereoFormat = AVAudioFormat(standardFormatWithSampleRate: 44100, channels: 2)
            _audioEngine.connect(_audioPlayer, to: _audioEngine.mainMixerNode, format: stereoFormat)
            
            do {
                if !_audioEngine.isRunning {
                    try _audioEngine.start()
                }
            } catch {
                print(error.localizedDescription)
            }
        }
        
        if let path = self.path {
            let fileUrl = URL(fileURLWithPath: path)
            do {
                let asset = try AVAudioFile(forReading: fileUrl)
                _audioPlayer.scheduleFile(asset, at: nil, completionHandler: nil)
                _audioPlayer.play()
            } catch {
                print ("asset error \(error.localizedDescription)")
            }
        }
        
        
    }
    
}

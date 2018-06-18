//
//  InterfaceController.swift
//  Metronome WatchKit Extension
//
//  Created by Giovani Nascimento Pereira on 15/06/18.
//  Copyright © 2018 Giovani Nascimento Pereira. All rights reserved.
//

import WatchKit
import Foundation

class InterfaceController: WKInterfaceController {

    @IBOutlet var label: WKInterfaceLabel!
    @IBOutlet var slider: WKInterfaceSlider!
    @IBOutlet var image: WKInterfaceImage!
    
    var timer: Timer = Timer()
    var play: Bool = false
    
    // Compass definitins
    var compassUp: Int = 4
    var compassCounter: Int = 0
    var soundState: Bool = false
    
    var pulse: Double {
        return 60.0/Double(bpm)
    }
    var bpm: Int = 120 {
        didSet {
            label.setText("\(bpm) BPM")
            if play {
                timer.invalidate()
                self.startMetronome()
            }
        }
    }
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        // Configure interface objects here.
        image.setImage(#imageLiteral(resourceName: "Play"))
        bpm = 120
    }
    
    func startMetronome() {
        timer = Timer.scheduledTimer(timeInterval: pulse, target: self, selector: #selector(updateMetronome), userInfo: nil, repeats: true)
    }
    
    func stopMetronome() {
        compassCounter = 0
        timer.invalidate()
    }
    
    override func willActivate() {
        super.willActivate()
        soundState = DefaultsManager.getSoundState()
        print(soundState)
    }
    
    @objc func updateMetronome() {
        compassCounter += 1
//        if compassCounter == compassUp {
//
//        } else {
//            if soundState {
//                AudioController.playAudio()
//            } else {
//                WKInterfaceDevice.current().play(.click)
//            }
//        }
        if soundState {
            AudioController.playAudio()
        } else {
            WKInterfaceDevice.current().play(.click)
        }
        compassCounter = 0
    }

    @IBAction func sliderChangeValue(_ value: Float) {
        bpm = Int(value)
    }
    @IBAction func tap(_ sender: Any) {
        play = !play
        if play {
            startMetronome()
            image.setImage(#imageLiteral(resourceName: "Pause"))
        } else {
            stopMetronome()
            image.setImage(#imageLiteral(resourceName: "Play"))
        }
    }
}

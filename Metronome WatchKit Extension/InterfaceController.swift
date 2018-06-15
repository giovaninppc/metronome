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
    
    var play: Bool = false
    var bpm: Int = 120 {
        didSet {
            label.setText("\(bpm) BPM")
        }
    }
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        // Configure interface objects here.
        image.setImage(#imageLiteral(resourceName: "Play"))
        bpm = 120
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    @IBAction func sliderChangeValue(_ value: Float) {
        bpm = Int(value)
    }
    @IBAction func tap(_ sender: Any) {
        if play {
            image.setImage(#imageLiteral(resourceName: "Pause"))
        } else {
            image.setImage(#imageLiteral(resourceName: "Play"))
        }
        
        play = !play
    }
}

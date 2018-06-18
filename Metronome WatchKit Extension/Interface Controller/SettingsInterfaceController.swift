//
//  SettingsInterfaceController.swift
//  Metronome WatchKit Extension
//
//  Created by Giovani Nascimento Pereira on 15/06/18.
//  Copyright © 2018 Giovani Nascimento Pereira. All rights reserved.
//

import WatchKit
import Foundation


class SettingsInterfaceController: WKInterfaceController {
    
    let list: [(String, String)] = [("Click", "little"), ("Roam", "asasas"), ("jhsdbfljhas", "hard")]
    @IBOutlet var soundSwitch: WKInterfaceSwitch!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        // Configure interface objects here.
        soundSwitch.setOn(DefaultsManager.getSoundState())
    }
    
    @IBAction func soundSwitchDidChangeValue(_ value: Bool) {
        DefaultsManager.setSoundState(to: value)
    }
    
}

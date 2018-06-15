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

    @IBOutlet var picker: WKInterfacePicker!
    
    let list: [String] = ["Click", "Roam", "BlugBlug"]
    let dict: [String: WKHapticType] = ["Click" : .click, "Roam": .directionUp,
                                        "BlugBlug": .directionDown]
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        // Configure interface objects here.
        populatePicker()
    }
    
    /// Add the items list to the picker
    func populatePicker () {
        var itemsArray: [WKPickerItem] = []
        for item in list {
            let newItem = WKPickerItem()
            newItem.title = item
            itemsArray.append(newItem)
        }
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    @IBAction func pickerChanged(_ value: Int) {
    }
    
}

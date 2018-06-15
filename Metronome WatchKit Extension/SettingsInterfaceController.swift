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
    
    let list: [(String, String)] = [("Click", "little"), ("Roam", "asasas"), ("jhsdbfljhas", "hard")]
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        // Configure interface objects here.
        populatePicker()
    }
    
    /// Add the items list to the picker
    func populatePicker () {
        let pickerItems: [WKPickerItem] = list.map { (title, caption) -> WKPickerItem in
            let pickerItem = WKPickerItem()
            pickerItem.caption = caption
            pickerItem.title = title
//            pickerItem.contentImage = WKImage(image: #imageLiteral(resourceName: "Play"))
            return pickerItem
        }
        picker.setItems(pickerItems)
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        populatePicker()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    @IBAction func pickerChanged(_ value: Int) {
    }
    
}

//
//  UserDefaultsManager.swift
//  Metronome WatchKit Extension
//
//  Created by Giovani Nascimento Pereira on 18/06/18.
//  Copyright © 2018 Giovani Nascimento Pereira. All rights reserved.
//

import Foundation

enum DefaultsKeys: String {
    case sound = "sound"
}

class DefaultsManager {
    
    class func getSoundState() -> Bool {
        return UserDefaults.standard.bool(forKey: DefaultsKeys.sound.rawValue)
    }
    
    class func setSoundState(to state: Bool) {
        UserDefaults.standard.set(state, forKey: DefaultsKeys.sound.rawValue)
    }
}

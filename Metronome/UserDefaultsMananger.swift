//
//  UserDefaultsMananger.swift
//  Metronome
//
//  Created by Giovani Nascimento Pereira on 18/06/18.
//  Copyright © 2018 Giovani Nascimento Pereira. All rights reserved.
//

import Foundation

enum UserDefaultsKeys: String {
    case animationState
}

class UserDefaultsManager {
    
    class func setAnimationState(to state: Bool) {
        UserDefaults.standard.set(state, forKey: UserDefaultsKeys.animationState.rawValue)
    }
    
    class func getAnimationState() -> Bool {
        return UserDefaults.standard.bool(forKey: UserDefaultsKeys.animationState.rawValue)
    }
    
}

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
    case numberExecutions
}

class UserDefaultsManager {
    
    class func setAnimationState(to state: Bool) {
        UserDefaults.standard.set(state, forKey: UserDefaultsKeys.animationState.rawValue)
    }
    
    class func getAnimationState() -> Bool {
        return UserDefaults.standard.bool(forKey: UserDefaultsKeys.animationState.rawValue)
    }
    
    class func updateNumberOfExecutions() {
        UserDefaults.standard.set(getNumberOfExecutions() + 1, forKey: UserDefaultsKeys.numberExecutions.rawValue)
    }
    
    class func getNumberOfExecutions() -> Int {
        return UserDefaults.standard.integer(forKey: UserDefaultsKeys.numberExecutions.rawValue)
    }
    
}

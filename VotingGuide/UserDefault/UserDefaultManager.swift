//
//  UserDefaultManager.swift
//  VotingGuide
//
//  Created by Ko Ko Aye  on 27/08/2020.
//  Copyright © 2020 Ko Ko Aye. All rights reserved.
//

import Foundation

class UserDefaultManager {
    static let shared = UserDefaultManager()
    let userDefault = UserDefaults.standard
    
    private let KEY_LANG = "key_for_languages"
    private let KEY_SELECTED_LANG = "key_for_selected_lang"
    
    func setLanguages(_ dict : [String:String]){
        userDefault.set(dict, forKey: KEY_LANG)
    }
    
    func selectLanguage(lang : String){
        userDefault.set(lang, forKey: KEY_SELECTED_LANG)
    }
    
    func getSelectedLanguage() -> String? {
        return userDefault.string(forKey: KEY_SELECTED_LANG)
    }
    
}

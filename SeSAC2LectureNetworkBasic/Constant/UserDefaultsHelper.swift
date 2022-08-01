//
//  UserDefaultsHelper.swift
//  SeSAC2LectureNetworkBasic
//
//  Created by Brother Model on 2022/08/01.
//

import UIKit

class UserDefaultsHelper {
    
    private init() { }
    
    // singleton pattern 자기 자신의 인스턴스를 타입 프로퍼티 형태로 가지고 있음
    static let standard = UserDefaultsHelper()
    
    let userDefaults = UserDefaults.standard
    
    enum Key:String {
    case nickname, age
    }
    
    var nickName:String {
        get {
            return userDefaults.string(forKey:Key.nickname.rawValue) ?? "대장"
        }
        set {
            userDefaults.set(newValue, forKey: Key.nickname.rawValue)
        }
    }
    
    var age: Int {
        get {
            return userDefaults.integer(forKey: Key.age.rawValue)
        }
        set {
            userDefaults.set(newValue, forKey: Key.age.rawValue)
        }
    }
}

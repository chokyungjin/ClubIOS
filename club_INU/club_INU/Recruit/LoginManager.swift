//
//  LoginManager.swift
//  club_INU
//
//  Created by 조경진 on 06/08/2019.
//  Copyright © 2019 dong.gyun. All rights reserved.
//

import Foundation

class LoginManager {
    
    static let loginManager = LoginManager()
    private init() {}
    private var isLogin: Bool = false
    
    func getLogin() -> Bool {
        return isLogin
    }
    func setLogin(isLogin : Bool) {
        self.isLogin = isLogin
    }
}

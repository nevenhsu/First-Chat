//
//  User.swift
//  First-Chat
//
//  Created by Neven on 22/10/2017.
//  Copyright © 2017 Neven. All rights reserved.
//

import Foundation

struct User {
    
    private var _firstName: String!
    private var _uid: String!
    
    var firstName: String {
        get {
            return _firstName
        }
        set {
            _firstName = newValue
        }
    }
    
    var uid: String {
        get {
            return _uid
        }
        set {
            _uid = newValue
        }
    }
    
    init(uid: String,firstName: String) {
        _firstName = firstName
        _uid = uid
    }
    
}

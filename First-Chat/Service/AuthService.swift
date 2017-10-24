//
//  AuthService.swift
//  First-Chat
//
//  Created by Neven on 19/10/2017.
//  Copyright © 2017 Neven. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth

typealias completion = (_ errMsg:String?,_ data: AnyObject?) -> ()

class AuthService {
    private static var _instance = AuthService()
    
    static var instance: AuthService {
        return _instance
    }
    
    func login(email: String, password: String, onComplete: completion?) {
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if let err = error as NSError? {
                if let errorCode = AuthErrorCode(rawValue: err.code), errorCode == .userNotFound {
                    // Create User
                    Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
                        if let err = error as NSError? {
                            // Show error to users
                            self.handleAuthError(error: err, onComplete: onComplete)
                            print("JESS: create failed")
                        } else {
                            if user?.uid != nil {
                                // Save UID to Database
                                DataService.instance.saveUser(uid: user!.uid)
                                
                                Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
                                    if let err = error as NSError? {
                                        // Show error to users
                                        self.handleAuthError(error: err, onComplete: onComplete)
                                        print("JESS: Sign in failed")
                                    } else {
                                        // Success
                                        onComplete?(nil,user)
                                        print("JESS: Sign in successfully")
                                    }
                                })
                            }
                        }
                    })
                } else {
                    self.handleAuthError(error: err, onComplete: onComplete)
                    print("JESS: Sign in failed")
                }
            } else {
                // Success
                onComplete?(nil,user)
                print("JESS: Sign in successfully")
            }
        }
    }
    
    func handleAuthError(error: NSError, onComplete: completion?) {
        if let errorCode = AuthErrorCode(rawValue: error.code) {
            switch errorCode {
            case .invalidEmail:
                onComplete?("Invail email address", nil)
            case .wrongPassword:
                onComplete?("Invaild password", nil)
            case .emailAlreadyInUse:
                onComplete?("Could not create account. Email already in use", nil)
            default:
                onComplete?("There was a problem authenticating. Try again.", nil)
            }
        }
    }
    
}

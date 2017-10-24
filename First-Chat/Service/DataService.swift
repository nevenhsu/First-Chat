//
//  DatabaseService.swift
//  First-Chat
//
//  Created by Neven on 21/10/2017.
//  Copyright © 2017 Neven. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseStorage

let FIR_USERS = "users"

class DataService {
    
    private static var _instance = DataService()
    
    static var instance: DataService {
        return _instance
    }
    
    var storageRef: StorageReference {
        return Storage.storage().reference(forURL: "gs://first-chat-d582b.appspot.com/")
    }
    
    var videoRef: StorageReference {
        return storageRef.child("videos")
    }
    
    var mainRef: DatabaseReference {
        return Database.database().reference()
    }
    
    var usersRef: DatabaseReference {
        return mainRef.child(FIR_USERS)
    }
    
    func saveUser(uid: String) {
        let profile: [String: String] = ["firstName": "Neven","lastName": "Xu"]
        mainRef.child("\(FIR_USERS)/\(uid)/profile").setValue(profile)
    }
    
    func uploadPullRequest(mediaURL: URL, senderUid: String, toUsers: [String: User], snipperChat: String? = nil ) {
        
        var uids = [String]()
        
        for key in toUsers.keys {
            uids.append(key)
        }
        
        let pr : [String:AnyObject] = ["mediaUrl" : mediaURL.absoluteString as AnyObject, "sender" : senderUid as AnyObject, "recipients": uids as AnyObject, "snipper": snipperChat as AnyObject]
        
        mainRef.child("pullRequests").childByAutoId().setValue(pr)
        
    }
    
}

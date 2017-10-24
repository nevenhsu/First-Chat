//
//  UserVC.swift
//  First-Chat
//
//  Created by Neven on 22/10/2017.
//  Copyright © 2017 Neven. All rights reserved.
//

import UIKit
import Firebase

class UserVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    @IBOutlet weak var tableView: UITableView!
    var users = [User]()
    var selectedUsers = Dictionary<String,User>()
    
    private var _videoUrl: URL?
    
    var videoUrl: URL? {
        get {
            return _videoUrl
        } set {
            _videoUrl = newValue
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsMultipleSelection = true
        
        navigationItem.rightBarButtonItem?.isEnabled = false
        
        // Download User from Database
        DataService.instance.usersRef.observeSingleEvent(of: .value) { (snapShot) in
            if let users = snapShot.value as? [String:AnyObject] {
                for (key, value) in users {
                    if let dict = value as? [String:AnyObject] {
                        if let profile = dict["profile"] as? [String: AnyObject] {
                            if let firstName = profile["firstName"] as? String {
                                let uid = key
                                let user = User(uid: uid, firstName: firstName)
                                self.users.append(user)
                            }
                        }
                    }
                }
            }
            self.tableView.reloadData()
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as? UserCell {
            let user = users[indexPath.row]
            cell.updateUI(user: user)
            return cell
        }
        return UITableViewCell()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        toggleUserCell(selected: true, indexPath: indexPath)
        navigationItem.rightBarButtonItem?.isEnabled = true
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        toggleUserCell(selected: false, indexPath: indexPath)
        navigationItem.rightBarButtonItem?.isEnabled = selectedUsers.count > 0
    }
    
    func toggleUserCell(selected: Bool, indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! UserCell
        let user = users[indexPath.row]
        
        if selected {
            cell.setMark(selected: true)
            selectedUsers[user.uid] = user
        } else {
            cell.setMark(selected: false)
            selectedUsers[user.uid] = nil
        }
    }
    
    @IBAction func sentBtnPressed(_ sender: Any) {
        if videoUrl != nil {
            
            let uuid = "\(NSUUID().uuidString)\(videoUrl)"
            
            DataService.instance.videoRef.child(uuid).putFile(from: videoUrl!, metadata: nil, completion: { (metadata, err) in
                if err != nil {
                    print("JESS: Uploading video failed - Error: \(err!.localizedDescription)")
                } else {
                    if let downloadUrl = metadata?.downloadURL() {
                        // Save download url to database
                        
                        DataService.instance.uploadPullRequest(mediaURL: downloadUrl, senderUid: Auth.auth().currentUser!.uid, toUsers: self.selectedUsers, snipperChat: "So Cool!")
                    }
                }
            })
            dismiss(animated: true, completion: nil)
        }
    }
    
    
    
    
}

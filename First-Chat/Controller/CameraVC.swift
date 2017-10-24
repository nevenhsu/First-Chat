//
//  ViewController.swift
//  First-Chat
//
//  Created by Neven on 06/10/2017.
//  Copyright © 2017 Neven. All rights reserved.
//

import UIKit
import FirebaseAuth

class CameraVC: CameraViewController, FileOutputDelegate {
    @IBOutlet weak var cameraBtn: UIButton!
    @IBOutlet weak var recordBtn: UIButton!
    @IBOutlet weak var resumeBtn: UIButton!
    
    @IBOutlet weak var previewView: PreviewView!
    
    override func viewDidLoad() {
        _previewView = previewView
        _cameraButton = cameraBtn
        _recordButton = recordBtn
        _resumeButton = resumeBtn
        
        super.viewDidLoad()
        super.delegate = self
        toggleCaptureMode(1)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        guard Auth.auth().currentUser != nil else {
            performSegue(withIdentifier: "LoginVC", sender: nil)
            return
        }
    }
    
    func videoRecordingFailed() {
        print("JESS: Video recording failed.")
    }
    
    func videoRecordingComplete(url: URL) {
        performSegue(withIdentifier: "UserVC", sender: ["videoURL": url])
    }
    

    @IBAction func recordBtnPressed(_ sender: Any?) {
        toggleMovieRecording()
        print("JESS: record Btn tapped")
    }
    
    @IBAction func cameraBtnPressed(_ sender: UIButton) {
        changeCamera()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let userVC = segue.destination as? UserVC, segue.identifier == "UserVC" {
            if let dict = sender as? [String: URL], let url = dict["videoURL"] {
                userVC.videoUrl = url
            }
        }
    }
    

}


//
//  ViewController.swift
//  First-Chat
//
//  Created by Neven on 06/10/2017.
//  Copyright © 2017 Neven. All rights reserved.
//

import UIKit
import FirebaseAuth

class CameraVC: CameraViewController {
    @IBOutlet weak var cameraBtn: UIButton!
    @IBOutlet weak var recordBtn: UIButton!
    
    @IBOutlet weak var previewView: PreviewView!
    
    override func viewDidLoad() {
        _previewView = previewView
        _cameraButton = cameraBtn
        _recordButton = recordBtn
        
        super.viewDidLoad()
        toggleCaptureMode(1)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        guard Auth.auth().currentUser != nil else {
            performSegue(withIdentifier: "LoginVC", sender: nil)
            return
        }
        
        
    }

    @IBAction func recordBtnPressed(_ sender: UIButton) {
        toggleMovieRecording()
        print("JESS: record Btn tapped")
    }
    
    @IBAction func cameraBtnPressed(_ sender: UIButton) {
        changeCamera()
    }
    


}


//
//  FileOutputDelegate.swift
//  First-Chat
//
//  Created by Neven on 23/10/2017.
//  Copyright © 2017 Neven. All rights reserved.
//

import Foundation


protocol FileOutputDelegate {
    func videoRecordingComplete(url: URL)
    func videoRecordingFailed()
}

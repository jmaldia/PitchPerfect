//
//  RecordedAudio.swift
//  PitchPerfect
//
//  Created by Jon Maldia on 7/13/15.
//  Copyright (c) 2015 Jon Maldia. All rights reserved.
//

import Foundation

class RecordedAudio {
    var filePathUrl: NSURL!
    var title: String!
    
    //        Task 1 - initialize vars
    init(filePathUrl: NSURL, title: String) {
        self.filePathUrl = filePathUrl
        self.title = title
    }
}
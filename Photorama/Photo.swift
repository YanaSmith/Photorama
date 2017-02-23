//
//  Photo.swift
//  Photorama
//
//  Created by Standart+ on 2/21/17.
//  Copyright © 2017 Yana Docheva. All rights reserved.
//

import Foundation

class Photo {
    
    let title: String
    let remoteURL: URL
    let photoId: String
    let dateTaken: Date
    
    init(title: String, photoId: String, remoteURL: URL, dateTaken: Date) {
        self.title = title
        self.remoteURL = remoteURL
        self.photoId = photoId
        self.dateTaken = dateTaken
    }
    
    
    
}

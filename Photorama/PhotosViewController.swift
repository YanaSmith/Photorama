//
//  PhotosViewController.swift
//  Photorama
//
//  Created by Standart+ on 2/21/17.
//  Copyright © 2017 Yana Docheva. All rights reserved.
//

import UIKit

class PhotosVewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    
    var store: PhotoStore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        store.fetchInterestingPhotos { (photoResult) in
            
            switch photoResult {
            case let .success(photos):
                //Using let to store [Photo] in photos constant
                print("Successefully found \(photos.count) photos.")
            case let .failure(error):
                print("Error fetching interesting photos: \(error)")
                
                
            }
        }
    }
}

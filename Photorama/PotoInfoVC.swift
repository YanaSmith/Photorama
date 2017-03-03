//
//  PotoInfoVC.swift
//  Photorama
//
//  Created by Standart+ on 3/2/17.
//  Copyright © 2017 Yana Docheva. All rights reserved.
//

import UIKit

class PhotoInfoVC: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    
    //Update the navigation item to displey the title of the photo
    var photo: Photo! {
        
        didSet {
            
            navigationItem.title = photo.title
        }
    }
    
    var store: PhotoStore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        store.fetchImage(for: photo) { (result) in
            
            switch result {
                
            case let .success(image):
                self.imageView.image = image
                
            case let .failure(error):
                print("Error fetching image for photot \(error)")
            }
        }
    }
    
}

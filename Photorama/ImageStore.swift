//
//  ImageStore.swift
//  Photorama
//
//  Created by Standart+ on 3/2/17.
//  Copyright © 2017 Yana Docheva. All rights reserved.
//

import UIKit

class ImageStore {
    
    let cache = NSCache<NSString, UIImage>()
    
    //Method for adding to cache dictionary
    func setImage (image: UIImage, forKey key: String){
        
        cache.setObject(image, forKey: key as NSString)
    }
    //Method for retrieving from cache
    func image(forKey key: String) -> UIImage? {
        
        return cache.object(forKey: key as NSString)
    }
    
    func deleteImage(forKey key: String) {
        cache.removeObject(forKey: key as NSString)
        
    }
    
}

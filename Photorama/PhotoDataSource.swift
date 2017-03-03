//
//  PhotoDataSource.swift
//  Photorama
//
//  Created by Standart+ on 2/28/17.
//  Copyright © 2017 Yana Docheva. All rights reserved.
//

import UIKit

 //To comform to UICVDSourse a type needs to comform to NSObject. For thid reason we subclass it from NSObject
class PhotoDataSourse: NSObject, UICollectionViewDataSource {
    
    var photos = [Photo]()
    
  //Mark: UICollectionView  required methiods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        let identifier = "PhotoCollectionViewCell"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! PhotoCollectionViewCell
        
        return cell
    }
}

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
    
    @IBOutlet weak var getRecentButton: UIButton!
    
    @IBOutlet weak var getListButton: UIButton!
    
    
    
    var store: PhotoStore!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
    }
    
    @IBAction func getRecent(_ sender: UIButton) {
       
       UserDefaults.standard.set(true, forKey: "getRecent")
        
       self.getListButton.isHidden = true
       self.getRecentButton.isHidden = true
        
       self.store.fetchInterestingPhotos { (photoResult) in
            
            switch photoResult {
            case let .success(photos):
                //Using let to store [Photo] in photos constant
                print("Successefully found \(photos.count) photos.")
                
                if let firstPhoto = photos.first {
                    print("First photo is \(firstPhoto)")
                    self.updateImageView(for: firstPhoto)
                }
            case let .failure(error):
                print("Error fetching  recent photos: \(error)")
                
            }
        }
        
    }
    
    //Step7: Choose the method and calls 6 to  update Ui
    @IBAction func getList(_ sender: UIButton) {
        
        UserDefaults.standard.set(false, forKey: "getRecent")
        self.getListButton.isHidden = true
        self.getRecentButton.isHidden = true
        
        self.store.fetchInterestingPhotos { (photoResult) in
            
            switch photoResult {
            case let .success(photos):
                //Using let to store [Photo] in photos constant
                print("Successefully found \(photos.count) photos.")
                
                if let firstPhoto = photos.first {
                    print("First photo is \(firstPhoto)")
                    self.updateImageView(for: firstPhoto)
                }
            case let .failure(error):
                print("Error fetching  recent photos: \(error)")
                
            }
        }
        
    }
    
    //Step6: Uodates UI with the result of 5 and 5a
    func updateImageView(for photo: Photo){
        store.fetchImage(for: photo) {
         (imageResult) in
        
        switch imageResult {
        case let .success(image):
             self.imageView.image = image as UIImage
                
        case let .failure(error):
            print("Error in downloading image: \(error)")
        }
    }
  }
}

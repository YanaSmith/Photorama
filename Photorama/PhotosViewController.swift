//
//  PhotosViewController.swift
//  Photorama
//
//  Created by Standart+ on 2/21/17.
//  Copyright © 2017 Yana Docheva. All rights reserved.
//

import UIKit

class PhotosVewController: UIViewController, UICollectionViewDelegate {
    
    @IBOutlet weak var getRecentButton: UIButton!
    
    @IBOutlet weak var getListButton: UIButton!
    
    @IBOutlet var collectioView: UICollectionView!
    
    
    let photoDataSourse = PhotoDataSourse()
    
    var store: PhotoStore!
    
    let imageStore = ImageStore()
    
    let flowLayOutObj = UICollectionViewFlowLayout()
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        collectioView.dataSource = photoDataSourse
        collectioView.delegate = self
        
      
        
//        self.store.fetchInterestingPhotos { (photoResult) in
//            
//            switch photoResult {
//            case let .success(photos):
//               
//                print("Successefully found \(photos.count) photos")
//                
//                self.photoDataSourse.photos = photos
//                
//            case let .failure(error):
//                print("Error fetching  recent photos: \(error)")
//                self.photoDataSourse.photos.removeAll()
//            }
//            
//            self.collectioView.reloadSections(IndexSet(integer: 0))
//        }

        
    }
    
    // This delegate method is called every time the cell is getting desplayed on the screen. Downloads the image data only for views the the udser is attempting to see
    
    
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let photo = photoDataSourse.photos[indexPath.row]
        
        store.fetchImage(for: photo) { (result) in
            
            guard let photoIndex = self.photoDataSourse.photos.index(of: photo),
                case let .success(image) = result else {
                    return
            }
            
            let photoIndexPath = IndexPath(item: photoIndex, section: 0)
            
            //WHen the request finishes , only update the cell if if it's still visible
            
            if let cell = self.collectioView.cellForItem(at: photoIndexPath) as? PhotoCollectionViewCell {
                cell.update(with: image)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
        switch segue.identifier {
        case "showPhoto"?:
            
            if let selectedIndexPath = collectioView.indexPathsForSelectedItems?.first {
                
                let photo = photoDataSourse.photos[selectedIndexPath.row]
                let destinationVC = segue.destination as! PhotoInfoVC
                destinationVC.photo = photo
                destinationVC.store = store
            }
        default:
            preconditionFailure("Unexpected segue identifier")
        }
    }
    
    @IBAction func getRecent(_ sender: UIButton) {
       
       UserDefaults.standard.set(true, forKey: "getRecent")
        
       self.getListButton.isHidden = true
       self.getRecentButton.isHidden = true
        
        self.store.fetchInterestingPhotos { (photoResult) in
            
            switch photoResult {
            case let .success(photos):
                
                print("Successefully found \(photos.count) photos")
                
                self.photoDataSourse.photos = photos
                
            case let .failure(error):
                print("Error fetching  recent photos: \(error)")
                self.photoDataSourse.photos.removeAll()
            }
            
            self.collectioView.reloadSections(IndexSet(integer: 0))
        }

        
        
    }
    
    //Step7: Choose the method and calls 6 to  update Ui
    @IBAction func getList(_ sender: UIButton) {
        
        UserDefaults.standard.set(false, forKey: "getRecent")
        self.getListButton.isHidden = true
        self.getRecentButton.isHidden = true
        
        
        // Updating the collection view
        self.store.fetchInterestingPhotos { (photoResult) in
            
            switch photoResult {
            case let .success(photos):
                
                print("Successefully found \(photos.count) photos")
                
                self.photoDataSourse.photos = photos
                
            case let .failure(error):
                print("Error fetching  recent photos: \(error)")
                self.photoDataSourse.photos.removeAll()
            }
            
            self.collectioView.reloadSections(IndexSet(integer: 0))
        }

        
          }
    
    //Step6: Uodates UI with the result of 5 and 5a
//    func updateImageView(for photo: Photo){
//        store.fetchImage(for: photo) {
//         (imageResult) in
//        
//        switch imageResult {
//        case let .success(image):
//             self.imageView.image = image as UIImage
//                
//        case let .failure(error):
//            print("Error in downloading image: \(error)")
//        }
//    }
//  }
    
}

extension PhotosVewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
       let  collectioViewWidth = collectioView.bounds.size.width
       let numberOfItemsPerRow: CGFloat = 5
       let sectionInsetLeft = collectioView.alignmentRectInsets.left
        
       let itemWidth = (collectioViewWidth - 6 * sectionInsetLeft) / numberOfItemsPerRow
      
       return CGSize(width: itemWidth, height: itemWidth)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        collectioView.reloadData()
        
    }
}

//extension PhotosVewController {
//    func customizeView() -> CGSize {
//       
//       let collectionViewWidth = flowLayOutObj.collectionView?.bounds.size.width
//       let sectionInsetLef = flowLayOutObj.sectionInset.left
//       let sectionInsetRight = flowLayOutObj.sectionInset.right
//       flowLayOutObj.minimumInteritemSpacing = 10
//       flowLayOutObj.minimumLineSpacing = 10
//       let numberCellsPerRow: CGFloat = 4
//       let itemWidht = (collectionViewWidth! / numberCellsPerRow) - (sectionInsetLef + sectionInsetRight + 3 * flowLayOutObj.minimumInteritemSpacing)
//        return
//        
//    }


    




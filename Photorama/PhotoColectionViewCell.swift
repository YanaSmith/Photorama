//
//  PhotoColectionViewCell.swift
//  Photorama
//
//  Created by Standart+ on 2/28/17.
//  Copyright © 2017 Yana Docheva. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var spinner: UIActivityIndicatorView!
    
    
    // The spinner is animating only when the cell is not displying image
    func update(with image: UIImage?) {
        if let imageToDisplay = image {
            spinner.stopAnimating()
            imageView.image = imageToDisplay
            
        } else {
            
            spinner.startAnimating()
            imageView.image = nil
        }
    }
      //Reseting the cell to a spinnig state when the cell is first created
        
    override func awakeFromNib(){
        super.awakeFromNib()
        
        update(with: nil)
    }
    
    //Reseting the cell to a spinnig state when the cell is reused
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        update(with: nil)
    }
        

    
    
    
}

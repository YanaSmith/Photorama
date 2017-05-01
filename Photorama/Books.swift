//
//  Books.swift
//  Photorama
//
//  Created by Standart+ on 3/2/17.
//  Copyright © 2017 Yana Docheva. All rights reserved.
//

import UIKit


class Books: UICollectionViewFlowLayout {
    
    private var photoWidth: CGFloat = 300
    private var photoHeight: CGFloat = 300
    private var numberOfPhotos = 0
    private var currentPhoto = 0
    
    
    override func prepare() {
        super.prepare()
        
        collectionView?.decelerationRate = UIScrollViewDecelerationRateFast
        collectionView?.contentInset = UIEdgeInsets(top: 0, left: collectionView!.bounds.width / 2 - photoWidth / 2, bottom: 0,
            right: collectionView!.bounds.width / 2 - photoWidth / 2 )
        
           }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        //1
        var array = super.layoutAttributesForElements(in: rect)
        
        //2
        for attributes in array! {
            //3
            var frame = attributes.frame
            //4
            var distance = abs(collectionView!.contentOffset.x + collectionView!.contentInset.left - frame.origin.x)
            //5
            var scale = 0.7 * min(max(1 - distance / (collectionView!.bounds.width), 0.75), 1)
            //6
            attributes.transform = CGAffineTransform(scaleX: scale, y: scale)
        }
        
        return array
    }
    

}

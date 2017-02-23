//
//  PhotoStore.swift
//  Photorama
//
//  Created by Standart+ on 2/21/17.
//  Copyright © 2017 Yana Docheva. All rights reserved.
//

import Foundation
import UIKit

enum ImageResult {
    
    case success(UIImage)
    case failure(Error)
}






enum PhotoResult {
    case success([Photo])
    case failure(Error)
}


class PhotoStore {
    
    
    private let session: URLSession = {
        //let config = URLSessionConfiguration.default
        return URLSession(configuration: URLSessionConfiguration.default)
    }()
    
    private func processPhotoRequest(data: Data?, error: Error?) -> PhotoResult {
    guard let jsonData = data else {
        print("Error in processPhotoResult in PhotoStore")
        return .failure(error!)
    }
    return FlickrAPI.photos(fromJson: jsonData)
}
    
    func fetchInterestingPhotos(completion: @escaping (PhotoResult) -> Void)  {
       
        let url = FlickrAPI.interestingPhotosURL
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) { (data, response, error) in
            
           let result = self.processPhotoRequest(data: data, error: error)
            
           completion(result)
        }
        task.resume()
        
    }
    
}


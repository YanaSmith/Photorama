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

enum PhotoError {
    case ImageCreationError
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
    
    //Step 3a
    private func processPhotoRequest(data: Data?, error: Error?) -> PhotoResult {
    guard let jsonData = data else {
        print("Error in processPhotoResult in PhotoStore")
        return .failure(error!)
    }
    return FlickrAPI.photos(fromJson: jsonData)
}
    // Step3: Takes the url from 2, sends request and recieves data, uses 3a to check if we recieve json data
    func fetchInterestingPhotos(completion: @escaping (PhotoResult) -> Void)  {
       
       let url = FlickrAPI.interestingPhotosURL
        
        print("URL is: \(url)")
        
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) { (data, response, error) in
            
           let result = self.processPhotoRequest(data: data, error: error)
            
            OperationQueue.main.addOperation {
                completion(result)
            }
        }
        task.resume()
    }
    
    //Step6: makes a request with th url of got in 5
    func fetchImage(for photo: Photo, completion: @escaping (ImageResult) -> Void) {
        let photoURL = photo.remoteURL
        let request = URLRequest(url: photoURL)
        let task = session.dataTask(with: request) { (data, resonse, error) in
         
            guard  let responseHTTP = resonse as? HTTPURLResponse else {
                return
            }
            
            let header = responseHTTP.allHeaderFields
            let stat = responseHTTP.statusCode
           
            
        let result = self.processImageRequest(data: data, error: error)
           
            OperationQueue.main.addOperation {
                completion(result)
            }
        }
        task.resume()
    }
    
    // Step5a: gets image from the returned in 5 data
    private func processImageRequest(data: Data?, error: Error?) -> ImageResult {
         guard
            let imageData = data,
            let image = UIImage(data: imageData) else {
                
                if data == nil {
                    print("Didnt find data")
                    return .failure(error!)
                } else {
                    return .failure(PhotoError.ImageCreationError as! Error)
                }
        }
        
        return .success(image)
    }
    
}


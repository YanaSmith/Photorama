//
//  FlickrAPI.swift
//  Photorama
//
//  Created by Standart+ on 2/21/17.
//  Copyright © 2017 Yana Docheva. All rights reserved.
//

import Foundation

enum Method: String {
   
    case interestingPhotos = "flickr.interestingness.getList"
    case recentPhotos = "flickr.photos.getRecent"
    
}

enum FlickrError: Error {
    
    case invalidJSONData
}


struct FlickrAPI {
    
    private static let baseURLString = "https://api.flickr.com/services/rest?"
    private static let apiKey = "4a5fd55f7bb02d336bd336506fd5b91e"
    
    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter
    }()
    

 // 1.Func that can ccreate URL from "method", querry items
    private static func flickrURL(method: Method, parameters: [String: String]?) -> URL {
        
        var components = URLComponents(string: baseURLString)!
        var queryItems = [URLQueryItem]()
        
        let baseParameters = ["method": "\(method.rawValue)", "format": "json", "nojsoncallback": "1", "api_key": apiKey]
        
        for (key, value) in baseParameters {
            let item = URLQueryItem(name: key, value: value)
            queryItems.append(item)
        }
        
        if let additionalParam = parameters {
            for (key, value) in additionalParam {
                let item = URLQueryItem(name: key, value: value)
                queryItems.append(item)
          }
        }
        components.queryItems = queryItems
        print("URL: \(components.url) "
        )
        return components.url!
        
    }
    
    // 2. Call of 1. func flickrURl
        static var interestingPhotosURL: URL {
            
            let x = UserDefaults.standard.bool(forKey: "getRecent")
            if x {
            return flickrURL(method: .recentPhotos, parameters: ["extras": "url_h,date_taken"])
                
            } else {
             return flickrURL(method: .interestingPhotos, parameters: ["extras": "url_h,date_taken"])
            }
        }
    
    // Steo4: Serialized json from step3 ana 3a, creating array of fotos
    static func photos(fromJson data: Data) -> PhotoResult {
        
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            
            guard
            let jsonDictionary = jsonObject as? [AnyHashable: Any],
            let photos = jsonDictionary["photos"] as? [String: Any],
            let photoArrey = photos["photo"] as? [[String: Any]] else {
                print("Error in func photos()")
                
                return PhotoResult.failure(FlickrError.invalidJSONData)
            }
            
            
            var finalPhotos = [Photo]()
            
            for photoJSON in photoArrey {
                
            if let photo = photo(fromJSON: photoJSON) {
                finalPhotos.append(photo)
                    
                }
                
            }
            
            if finalPhotos.isEmpty && !photoArrey.isEmpty {
                
                print("We weren't abel to parse any of the photos")
                //May be JSON format for photos has changed
                return .failure(FlickrError.invalidJSONData)
                
            }
            
            return .success(finalPhotos)
            
        } catch let error {
            return .failure(error)
            
        }
    }
    
    //Step5: Get the data of a single photo from the arrey of pphotos in 4. gets the remote url of the photo
        private static func photo(fromJSON json: [String : Any]) -> Photo? {
            
            guard
                let photoID = json["id"] as? String,
                let title = json["title"] as? String,
                let dateString = json["datetaken"] as? String,
                let photoURLString = json["url_h"] as? String,
                let url = URL(string: photoURLString),
                let dateTaken = dateFormatter.date(from: dateString) else {
                
                    print("Couldn't parse Photo" )
                    return nil 
            }
              print(" RemoteURL is \(url)")
            return Photo(title: title, photoId: photoID, remoteURL: url, dateTaken: dateTaken)
            
        }
        
    
}

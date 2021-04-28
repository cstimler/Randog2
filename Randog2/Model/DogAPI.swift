//
//  DogAPI.swift
//  Randog
//
//  Created by June2020 on 4/27/21.
//

import Foundation
import UIKit

class DogAPI {
    enum Endpoint {
        case randomImageFromAllDogsCollection
        case randomImageForBreed(String)
        
        var url: URL {
            return URL(string: self.stringValue)!
        }
            var stringValue: String {
                switch self {
                
                case .randomImageFromAllDogsCollection:
                    return "https://dog.ceo/api/breeds/image/random"
                case .randomImageForBreed(let breed):
                    return "https://dog.ceo/breed/\(breed)/images/random"
               
                }
            }
        }
    class func requestImageFile(url: URL, completionHandler: @escaping (UIImage?, Error?) -> Void ) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                completionHandler(nil, error)
                return
            }
            let downloadedImage = UIImage(data: data)
            completionHandler(downloadedImage, nil)
        }
        task.resume()
    }
    
    class func requestRandomImage(breed: String, completionHandler: @escaping (DogImage?, Error?) -> Void) {
        let randomImageEndpoint = Endpoint.randomImageForBreed(breed).url
        let task = URLSession.shared.dataTask(with: randomImageEndpoint) { (data, response, error) in
            guard let data = data else {
                completionHandler(nil, error)
                return
            }
            
            let decoder = JSONDecoder()
            let imageData = try? decoder.decode(DogImage.self, from: data)
            print(imageData)
            completionHandler(imageData, nil)
            }
        task.resume()
    }

}

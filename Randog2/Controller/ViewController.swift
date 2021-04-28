//
//  ViewController.swift
//  Randog
//
//  Created by June2020 on 4/27/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        DogAPI.requestRandomImage(completionHandler: self.handleRandomImageResponse(dogImage:error:))
}

    
    func handleImageFileResponse(image: UIImage?, error: Error?) {
        DispatchQueue.main.async {
            self.imageView.image = image
        }
    }
    func handleRandomImageResponse(dogImage: DogImage?, error: Error?) {
        let message = dogImage?.message
        if let message = message {
        guard let imageUrl = URL(string: message) else {
            print("Cannot create URL")
            return
        }
        DogAPI.requestImageFile(url: imageUrl, completionHandler: self.handleImageFileResponse(image:error:))
        } else {
            print("message is nil")
        }
}
}

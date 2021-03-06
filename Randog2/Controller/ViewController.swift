//
//  ViewController.swift
//  Randog
//
//  Created by June2020 on 4/27/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    var breeds: [String] = ["poodle", "greyhound"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.dataSource = self
        pickerView.delegate = self
        DogAPI.requestBreedsList(completionHandler: self.handleBreedsListResponse(breeds:error:))
        
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
    
    func handleBreedsListResponse(breeds: [String]?, error: Error?) {
        guard let breeds = breeds else {
            print("No breeds list")
            return
        }
        self.breeds = breeds
        DispatchQueue.main.async {
            self.pickerView.reloadAllComponents()
        }
    }
 }

extension ViewController:
    UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return breeds.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return breeds[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        DogAPI.requestRandomImage(breed: breeds[row], completionHandler: self.handleRandomImageResponse(dogImage:error:))
    }
}

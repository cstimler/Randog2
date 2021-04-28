//
//  DogBreeds.swift
//  Randog2
//
//  Created by June2020 on 4/28/21.
//

import Foundation

struct SubBreeds: Codable {
    let String: [String]
}


struct DogBreeds: Codable {
    let message: [String: [String]]
    let status: String
 
    enum CodingKeys: String, CodingKey {
        case message
        case status
    }
}

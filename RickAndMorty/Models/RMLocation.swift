//
//  RMLocation.swift
//  RickAndMorty
//
//  Created by Mustafa Ali Dikcinar on 7.06.2023.
//

import Foundation

struct BasicLocation: Codable {
    let name, url: String
}

struct Location: Codable {
    let id: Int
    let name, type, dimension: String
    let residents: [String]
    let url: String
    let created: String
}

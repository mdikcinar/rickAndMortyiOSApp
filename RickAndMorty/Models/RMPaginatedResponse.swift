//
//  RMPaginatedResponse.swift
//  RickAndMorty
//
//  Created by Mustafa Ali Dikcinar on 11.06.2023.
//

import Foundation

struct RMPaginatedResponse<T: Codable>: Codable {
    let info: RMPaginatedInfo
    let results: [T]
}

//
//  RMPaginatedInfo.swift
//  RickAndMorty
//
//  Created by Mustafa Ali Dikcinar on 11.06.2023.
//

import Foundation

struct RMPaginatedInfo: Codable {
    let count, pages: Int
    let next, prev: String?
}

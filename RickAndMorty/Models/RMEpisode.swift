//
//  RMEpisodes.swift
//  RickAndMorty
//
//  Created by Mustafa Ali Dikcinar on 7.06.2023.
//

import Foundation

struct Episode: Codable {
    let id: Int
    let name, airDate, episode: String
    let characters: [String]
    let url: String
    let created: String
}

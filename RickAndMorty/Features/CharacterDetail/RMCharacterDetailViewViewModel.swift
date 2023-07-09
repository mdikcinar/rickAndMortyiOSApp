//
//  RMCharacterDetailViewViewModel.swift
//  RickAndMorty
//
//  Created by Mustafa Ali Dikcinar on 9.07.2023.
//

import Foundation

final class RMCharacterDetailViewViewModel {
    private let character: RMCharacter

    init(character: RMCharacter) {
        self.character = character
    }

    public var title: String {
        return character.name
    }
}

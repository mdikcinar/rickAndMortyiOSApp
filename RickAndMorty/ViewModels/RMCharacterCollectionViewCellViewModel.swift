//
//  RMCharacterCollectionViewCellViewModel.swift
//  RickAndMorty
//
//  Created by Mustafa Ali Dikcinar on 11.06.2023.
//

import Foundation

final class RMCharacterCollectionViewCellViewModel {
    public let characterName: String
    public let characterStatusText: RMCharacterStatus
    public let characterImageUrl: URL?

    // MARK: - Init

    init(
        characterName: String,
        characterStatusText: RMCharacterStatus,
        characterImageUrl: URL?
    ) {
        self.characterName = characterName
        self.characterStatusText = characterStatusText
        self.characterImageUrl = characterImageUrl
    }

    public var getCharacterStatysText: String {
        return "Status: \(characterStatusText.text)"
    }

    public func fetchImage(completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = characterImageUrl else {
            completion(.failure(URLError(.badURL)))
            return
        }
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? URLError(.badServerResponse)))
                return
            }

            completion(.success(data))
        }.resume()
    }
}

//
//  RMRequest.swift
//  RickAndMorty
//
//  Created by Mustafa Ali Dikcinar on 10.06.2023.
//

import Foundation

final class RMRequest {
    private enum Constants {
        static let baseURL = "https://rickandmortyapi.com/api/"
    }

    private let endpoint: RMEndpoint
    private let pathComponents: [String]
    private let queryParametters: [URLQueryItem]

    private var urlString: String {
        var string = Constants.baseURL
        string.append("/\(endpoint.rawValue)")
        if !pathComponents.isEmpty {
            string.append("/\(pathComponents.joined(separator: "/"))")
        }
        if !queryParametters.isEmpty {
            string.append("?\(queryParametters.map { "\($0.name)=\($0.value ?? "")" }.joined(separator: "&"))")
        }
        return string
    }

    // MARK: - Public

    public var url: URL? {
        URL(string: urlString)
    }

    public var httpMethod: String {
        "GET"
    }

    public init(
        endpoint: RMEndpoint,
        pathComponents: [String] = [],
        queryParametters: [URLQueryItem] = []
    ) {
        self.endpoint = endpoint
        self.pathComponents = pathComponents
        self.queryParametters = queryParametters
    }
}

extension RMRequest {
    static let listCharactersRequest = RMRequest(endpoint: .character)
}

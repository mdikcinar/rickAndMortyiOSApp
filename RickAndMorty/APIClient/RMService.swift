//
//  RMService.swift
//  RickAndMorty
//
//  Created by Mustafa Ali Dikcinar on 10.06.2023.
//

import Foundation

final class RMService {
    static let shared = RMService()

    private init() {}

    public func excecute<T: Codable>(
        _ request: RMRequest,
        expectedType: T.Type,
        completor: @escaping (Result<T, Error>) -> Void) {}
}

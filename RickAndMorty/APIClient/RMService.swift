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

    func excecute(_ request: RMRequest, completor: @escaping () -> Void) {}
}

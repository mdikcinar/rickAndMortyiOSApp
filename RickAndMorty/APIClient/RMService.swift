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

    enum RMServiceError: Error {
        case failedToCreateRequest
        case failedToGetData
        case failedToDecode
        case invalidURL
    }

    public func execute<T: Codable>(
        _ request: RMRequest,
        expecting type: T.Type,
        completion: @escaping (Result<T, Error>) -> Void)
    {
        var urlRequest = self.request(from: request)
        guard urlRequest != nil else {
            completion(.failure(RMServiceError.failedToCreateRequest))
            return
        }

        let task = URLSession.shared.dataTask(with: urlRequest!) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? RMServiceError.failedToGetData))
                return
            }

            do {
                let result = try JSONDecoder().decode(type.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }

    // MARK: - Private

    private func request(from rmRequest: RMRequest) -> URLRequest? {
        guard let url = rmRequest.url else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = rmRequest.httpMethod

        return request
    }
}

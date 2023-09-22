//
//  UserServiceApi.swift
//  isOnGithub
//
//  Created by Salvatore Palazzo on 2023-09-22.
//

import Foundation
import UIKit

final class UserServiceApi {

    enum ApiError: Error {
        case requestError
        case parsingError
        case responseError
        case serverError(code: Int)
        case unknownError
    }

    func makeRequest(from urlString: String) throws -> URLRequest {
        guard let url = URL(string: urlString) else {
            throw ApiError.requestError
        }
        return URLRequest(url: url)
    }

    func sendRequest<T: Decodable>(urlString: String,
                                   dataModel: T.Type) async throws -> Result<T, ApiError> {
        
        let request = try makeRequest(from: urlString)

        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let response = response as? HTTPURLResponse else { return .failure(.responseError) }

            switch response.statusCode {
            case 200...299:
                guard let decodedResponse = try? JSONDecoder().decode(dataModel, from: data) else {
                    return .failure(.parsingError)
                }
                return .success(decodedResponse)
            default: return .failure(.serverError(code: response.statusCode))
            }
            
        } catch {
            return .failure(.unknownError)
        }
    }

    func getUserByUsername(username: String) async throws -> Result <User, ApiError> {
        let endpoint = Endpoint.userWithId(username).url
        return try await sendRequest(urlString: endpoint, dataModel: User.self)
    }


    func searchByUsername(username: String) async throws -> String {
        let endpoint = Endpoint.userWithId(username).url
        let result = try await sendRequest(urlString: endpoint, dataModel: User.self)
        switch result {
        case .success(let user): return user.name
        case .failure(let error): return error.localizedDescription
        }
    }
}


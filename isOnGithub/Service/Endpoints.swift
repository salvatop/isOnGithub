//
//  Endpoints.swift
//  isOnGithub
//
//  Created by Salvatore Palazzo on 2023-09-22.
//

enum Endpoint {
    private var baseURL: String { return "https://api.github.com" }

    case users
    case userWithId(String)

    var url: String {
        var path: String

        switch self {
        case .users: path = "/users"
        case .userWithId(let id): path = "/users/\(id)"
        }
        return baseURL + path
    }
}


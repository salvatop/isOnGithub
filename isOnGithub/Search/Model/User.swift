//
//  User.swift
//  isOnGithub
//
//  Created by Salvatore Palazzo on 2023-09-22.
//

struct User: Codable {

    var login: String
    var id: Int
    var nodeId: String?
    var avatarUrl: String?
    var gravatarId: String?
    var url: String?
    var htmlUrl : String?
    var followersUrl: String?
    var followingUrl: String?
    var gistsUrl: String?
    var starredUrl: String?
    var subscriptionsUrl: String?
    var organizationsUrl: String?
    var reposUrl: String?
    var eventsUrl: String?
    var receivedEventsUrl: String?
    var type: String?
    var siteAdmin: Bool?
    var name: String
    var company: String?
    var blog: String?
    var location: String?
    var email: String?
    var hireable: String?
    var bio: String?
    var twitterUsername: String?
    var publicRepos: Int?
    var publicGists: Int?
    var followers: Int?
    var following: Int?
    var createdAt: String?
    var updatedAt: String?

    enum CodingKeys: String, CodingKey {

        case login
        case id
        case nodeId = "node_id"
        case avatarUrl = "avatar_url"
        case gravatarId = "gravatar_id"
        case url
        case htmlUrl = "html_url"
        case followersUrl = "followers_url"
        case followingUrl = "following_url"
        case gistsUrl = "gists_url"
        case starredUrl = "starred_url"
        case subscriptionsUrl = "subscriptions_url"
        case organizationsUrl = "organizations_url"
        case reposUrl = "repos_url"
        case eventsUrl = "events_url"
        case receivedEventsUrl = "received_events_url"
        case type
        case siteAdmin = "site_admin"
        case name
        case company
        case blog
        case location
        case email
        case hireable
        case bio
        case twitterUsername = "twitter_username"
        case publicRepos = "public_repos"
        case publicGists = "public_gists"
        case followers
        case following
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        login = try values.decode(String.self, forKey: .login)
        id = try values.decode(Int.self, forKey: .id)
        avatarUrl = try values.decodeIfPresent(String.self, forKey: .avatarUrl)
        followersUrl = try values.decodeIfPresent(String.self, forKey: .followingUrl)
        followingUrl = try values.decodeIfPresent(String.self, forKey: .followingUrl)
        name = try values.decode(String.self, forKey: .name)
        bio = try values.decodeIfPresent(String.self, forKey: .bio)
        followers = try values.decodeIfPresent(Int.self, forKey: .followers)
        following = try values.decodeIfPresent(Int.self, forKey: .following)
    }
}

extension User {

    enum Kind: String {
        case followers
        case following
    }
}


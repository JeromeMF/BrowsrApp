//
//  BrowsrModel.swift
//  BrowsrApp
//
//  Created by Jérôme Figueiredo on 13/10/2022.
//

import Foundation

// MARK: - UserModel
struct UserModel: Codable {
    let totalCount: Int
    let incompleteResults: Bool
    let items: [Item]
    
    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case incompleteResults = "incomplete_results"
        case items
    }
}

// MARK: - Item
struct Item: Codable, Hashable {
    let login: String
    let id: Int
    let nodeID: String
    let avatarURL: String
    let gravatarID: String
    let url: String
    let htmlURL: String
    let followersURL: String
    let subscriptionsURL: String
    let organizationsURL: String
    let reposURL: String
    let receivedEventsURL: String
    let type: String
    let score: Int
    let followingURL: String
    let gistsURL: String
    let starredURL: String
    let eventsURL: String
    let siteAdmin: Bool
    
    enum CodingKeys: String, CodingKey {
        case login
        case id
        case nodeID = "node_id"
        case avatarURL = "avatar_url"
        case gravatarID = "gravatar_id"
        case url
        case htmlURL = "html_url"
        case followersURL = "followers_url"
        case subscriptionsURL = "subscriptions_url"
        case organizationsURL = "organizations_url"
        case reposURL = "repos_url"
        case receivedEventsURL = "received_events_url"
        case type
        case score
        case followingURL = "following_url"
        case gistsURL = "gists_url"
        case starredURL = "starred_url"
        case eventsURL = "events_url"
        case siteAdmin = "site_admin"
    }
}


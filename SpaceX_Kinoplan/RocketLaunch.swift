//
//  RocketLaunch.swift
//  SpaceX_Kinoplan
//
//  Created by Александр on 25.01.2024.
//

import Foundation

struct RocketLaunch: Decodable, Hashable {
    
    let missionName: String?
    let links: Links?
    let launchDateLocal: String?
    
    enum CodingKeys: String, CodingKey {
        case missionName = "mission_name"
        case links = "links"
        case launchDateLocal = "launch_date_local"
    }
    static func == (lhs: RocketLaunch, rhs: RocketLaunch) -> Bool {
        lhs.missionName == rhs.missionName
    }
}
struct Links: Decodable, Hashable {
    let missionPatch: String?
    let redditLaunch: String?
    let wikipedia: String?
    let videoLink: String?
    let youtubeId: String?
    let articleLink: String?
    let flickrImages: [String]?
    
    enum CodingKeys: String, CodingKey {
        case missionPatch = "mission_patch"
        case redditLaunch = "reddit_launch"
        case wikipedia = "wikipedia"
        case videoLink = "video_link"
        case youtubeId = "youtube_id"
        case articleLink = "article_link"
        case flickrImages = "flickr_images"
    }
}

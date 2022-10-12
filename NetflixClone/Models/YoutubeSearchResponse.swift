//
//  SearchResponse.swift
//  NetflixClone
//
//  Created by ekincare on 12/10/22.
//

import Foundation

struct YoutubeSearchResults: Codable{
    let items: [VideoElement]
}

struct VideoElement: Codable{
    let id: IdVideoElement
}

struct IdVideoElement: Codable{
    let kind: String
    let videoId: String
}

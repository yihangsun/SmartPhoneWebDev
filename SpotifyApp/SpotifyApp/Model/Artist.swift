//
//  Artist.swift
//  SpotifyApp
//
//  Created by Yihang Sun on 4/22/21.
//

import Foundation

struct Artist: Codable {
    let id: String
    let name: String
    let type: String
    let images: [APIImage]?
    let external_urls: [String: String]
}

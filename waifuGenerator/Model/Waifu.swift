//
//  Waifu.swift
//  waifuGenerator
//
//  Created by vladislav bek on 15.08.23.
//

import Foundation

struct Waifu: Decodable {

    let images: ([Images])?
    
}

struct Images: Decodable {

    let url: String
    
    let tags: [Tags]
}

struct Tags: Decodable {
    let name: String
    let description: String // images[0].tags[1].description
    let is_nsfw: Bool
}


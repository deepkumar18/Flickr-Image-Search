//
//  FlickrImage.swift
//  FlickrImageSearch
//
//  Created by Deep kumar  on 9/27/24.
//

import Foundation

struct FlickrImage: Identifiable, Codable {
    let id: String
    let title: String
    let media: Media
    let author: String
    let description: String?
    let published: String
    
    enum CodingKeys: String, CodingKey {
        case id = "link"
        case title
        case author
        case description
        case published
        case media
    }
    struct Media: Codable {
        let m: String  // The medium-sized image URL
        let o: String? // The original image URL
    }
}


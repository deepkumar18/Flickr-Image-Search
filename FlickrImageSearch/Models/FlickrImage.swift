//
//  FlickrImage.swift .swift
//  FlickrImageSearch
//
//  Created by Deep kumar  on 9/27/24.
//

import Foundation

struct FlickrImage: Decodable, Identifiable {
    let id = UUID() // Unique identifier for SwiftUI
    let title: String
    let media: [String: String]
    let link: String
    let description: String?
    let author: String?
    let published: String

    var mediaURL: String {
        return media["m"] ?? ""
    }

    var formattedPublishedDate: String {
        let dateFormatter = ISO8601DateFormatter()
        guard let date = dateFormatter.date(from: published) else { return "Unknown Date" }
        
        let displayFormatter = DateFormatter()
        displayFormatter.dateStyle = .medium
        displayFormatter.timeStyle = .short
        return displayFormatter.string(from: date)
    }
}

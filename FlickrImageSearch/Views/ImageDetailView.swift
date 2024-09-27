//
//  ImageDetailView.swift
//  FlickrImageSearch
//
//  Created by Deep kumar  on 9/27/24.
//

import Foundation
import SwiftUI

struct ImageDetailView: View {
    let image: FlickrImage

    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: image.mediaURL)) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image.resizable()
                             .scaledToFit()
                             .frame(maxWidth: .infinity)
                    case .failure:
                        Color.red // Handle image loading failure
                    @unknown default:
                        EmptyView()
                    }
                }
                Text(image.title)
                    .font(.headline)
                    .padding()
                
                // Use the strippedHTML function to clean up the description
                if let description = image.description {
                    Text(description.strippedHTML())
                        .font(.body)
                        .padding()
                }
                
                Text("Author: \(image.author ?? "Unknown")")
                    .font(.subheadline)
                    .padding()
                Text("Published: \(image.formattedPublishedDate)")
                    .font(.subheadline)
                    .padding()
            }
        }
        .navigationTitle("Image Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}


extension String {
    func strippedHTML() -> String {
        guard let data = self.data(using: .utf8) else { return self }
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        do {
            let attributedString = try NSAttributedString(data: data, options: options, documentAttributes: nil)
            return attributedString.string
        } catch {
            return self // Return original string if there was an error
        }
    }
}

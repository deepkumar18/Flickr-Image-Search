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
    let animationNamespace: Namespace.ID // Animation namespace

    @State private var isShareSheetPresented = false

    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: image.media.m)) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(height: 300)
                    case .success(let img):
                        img.resizable()
                            .aspectRatio(contentMode: .fit)
                            .matchedGeometryEffect(id: image.id, in: animationNamespace) // Apply animation
                    case .failure:
                        Image(systemName: "photo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 300)
                    @unknown default:
                        EmptyView()
                    }
                }
                
                Text(image.title)
                    .font(.title)
                    .padding()

                Text(image.description?.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression) ?? "No description available.")
                    .padding()

                Text("Author: \(image.author)")
                    .padding()

                Text("Published: \(formattedDate(from: image.published))")
                    .padding()

                Button(action: {
                    shareImageAndMetadata()
                }) {
                    Label("Share", systemImage: "square.and.arrow.up")
                        .font(.title2)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.top, 20)
            }
        }
        .navigationTitle("Image Detail")
        .sheet(isPresented: $isShareSheetPresented) {
            ActivityView(activityItems: [URL(string: image.media.m)!, image.title])
        }
    }

    private func formattedDate(from dateString: String) -> String {
        let dateFormatter = ISO8601DateFormatter()
        if let date = dateFormatter.date(from: dateString) {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            return formatter.string(from: date)
        }
        return dateString
    }

    // Function to present the share sheet
     private func shareImageAndMetadata() {
         isShareSheetPresented = true
     }
 }

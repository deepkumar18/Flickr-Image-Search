//
//  ContentView.swift
//  FlickrImageSearch
//
//  Created by Deep kumar  on 9/27/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = FlickrViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Search for images...", text: $viewModel.searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .accessibilityLabel("Image search text field")
                    .accessibilityHint("Type a keyword or multiple keywords separated by commas.")
                    Spacer()

                if viewModel.images.isEmpty {
                    Text("No images found. Please enter a search term.")
                        .padding()
                } else {
                    GridView(images: viewModel.images)
                }
                Spacer()
            }
            .navigationTitle("Flickr Image Search")
        }
    }
}

struct GridView: View {
    let images: [FlickrImage]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2)) {
                ForEach(images) { image in
                    NavigationLink(destination: ImageDetailView(image: image)) {
                        AsyncImage(url: URL(string: image.mediaURL)) { img in
                            img.resizable()
                                .aspectRatio(contentMode: .fit)
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(height: 150)
                    }
                }
            }
            .padding()
        }
    }
}

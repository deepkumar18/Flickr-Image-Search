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
                    ImageGridView(viewModel: viewModel)
                }
                Spacer()
            }
            .navigationTitle("Flickr Image Search")
        }
    }
}

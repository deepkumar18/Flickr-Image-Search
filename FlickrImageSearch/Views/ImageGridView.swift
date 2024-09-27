//
//  ImageGridView.swift
//  FlickrImageSearch
//
//  Created by Deep kumar  on 9/27/24.
//

import SwiftUI

struct ImageGridView: View {
    @ObservedObject var viewModel: FlickrViewModel
    @Namespace private var animationNamespace // Namespace for animation

    var body: some View {
        ScrollView {
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3)) {
                ForEach(viewModel.images) { image in
                    NavigationLink(destination: ImageDetailView(image: image, animationNamespace: animationNamespace)) {
                        AsyncImage(url: URL(string: image.media.m)) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                                    .frame(width: 100, height: 100)
                            case .success(let img):
                                img.resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 100, height: 100)
                                    .clipped()
                                    .matchedGeometryEffect(id: image.id, in: animationNamespace) // Animation
                            case .failure:
                                Color.gray
                                    .frame(width: 100, height: 100)
                            @unknown default:
                                EmptyView()
                            }
                        }
                    }
                }
            }
            .padding()
        }
    }
}

//
//  FlickrServiceProtocol.swift 
//  FlickrImageSearch
//
//  Created by Deep kumar  on 9/27/24.
//

import Foundation
import SwiftUI
import Combine

// Protocol for Flickr Service to allow for dependency injection
protocol FlickrServiceProtocol {
    func fetchImages(for searchText: String, completion: @escaping (Result<FlickrResponse, Error>) -> Void)
}

class FlickrViewModel: ObservableObject {
    @Published var images: [FlickrImage] = []
    @Published var searchText: String = "" {
        didSet {
            fetchImages()
        }
    }
    @Published var isLoading: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    private var service: FlickrServiceProtocol // Use the protocol for dependency injection

    // Initialize with a service, defaulting to the real service
    init(service: FlickrServiceProtocol = FlickrService()) {
        self.service = service
    }

    func fetchImages() {
        guard !searchText.isEmpty else {
            images = []
            return
        }

        isLoading = true
        let formattedSearchText = searchText.replacingOccurrences(of: " ", with: ",")
        
        // Call the service to fetch images
        service.fetchImages(for: formattedSearchText) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
            }
            
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self?.images = response.items
                }
            case .failure(let error):
                print("Error fetching images: \(error)")
            }
        }
    }
}

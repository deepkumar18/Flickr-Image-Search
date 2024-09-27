//
//  MockFlickrService.swift
//  FlickrImageSearchTests
//
//  Created by Deep kumar  on 9/27/24.
//

import Foundation
@testable import FlickrImageSearch

class MockFlickrService: FlickrServiceProtocol {
    var mockResponse: FlickrResponse?

    func fetchImages(for searchText: String, completion: @escaping (Result<FlickrResponse, Error>) -> Void) {
        // Simulate success or failure based on mockResponse
        if let response = mockResponse {
            completion(.success(response))
        } else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No images found."])))
        }
    }
}

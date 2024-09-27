//
//  FlickrViewModelTests.swift
//  FlickrImageSearchTests
//
//  Created by Deep kumar  on 9/27/24.
//

import XCTest
@testable import FlickrImageSearch

class FlickrViewModelTests: XCTestCase {
    var viewModel: FlickrViewModel!
    var mockService: MockFlickrService!

    override func setUp() {
        super.setUp()
        mockService = MockFlickrService()
        viewModel = FlickrViewModel(service: mockService) // Use mock service
    }

    func testSearchImages() {
        // Prepare mock data
        let mockImage = FlickrImage(id: "1", title: "Test Image", media: .init(m: "http://example.com/test.jpg", o: "http://example.com/test.jpg"), author: "Author", description: "Description", published: "2024-09-27")
        let mockResponse = FlickrResponse(items: [mockImage])
        mockService.mockResponse = mockResponse

        viewModel.searchText = "test" // Trigger fetch

        // Wait for debounce and async behavior
        let expectation = self.expectation(description: "Wait for images to load")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertFalse(self.viewModel.images.isEmpty, "Should have images after search")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }

    func testEmptySearch() {
        viewModel.searchText = ""
        XCTAssertTrue(viewModel.images.isEmpty, "Images should be empty for empty search")
    }
}


import Foundation
import SwiftUI
import Combine

class FlickrViewModel: ObservableObject {
    @Published var images: [FlickrImage] = []
    @Published var searchText: String = "" {
        didSet {
            fetchImages()
        }
    }
    @Published var isLoading: Bool = false

    private var cancellables = Set<AnyCancellable>()

    func fetchImages() {
        guard !searchText.isEmpty else {
            images = []
            return
        }

        isLoading = true
        let formattedSearchText = searchText.replacingOccurrences(of: " ", with: ",")
        let urlString = "https://api.flickr.com/services/feeds/photos_public.gne?format=json&nojsoncallback=1&tags=\(formattedSearchText)"

        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            DispatchQueue.main.async {
                self?.isLoading = false
            }

            if let error = error {
                print("Error fetching images: \(error)")
                return
            }

            guard let data = data else {
                print("No data received")
                return
            }

            do {
                let response = try JSONDecoder().decode(FlickrResponse.self, from: data)
                DispatchQueue.main.async {
                    self?.images = response.items
                }
            } catch {
                print("Error decoding response: \(error)")
            }
        }.resume()
    }
}


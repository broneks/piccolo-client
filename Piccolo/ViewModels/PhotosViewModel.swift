import SwiftUI

class PhotosViewModel: ObservableObject {
    @Published var photos: [Photo]?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    func fetchPhotos() async {
        isLoading = true
        do {
            photos = try await APIService.shared.fetchData(method: "GET", path: "photos")
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
}

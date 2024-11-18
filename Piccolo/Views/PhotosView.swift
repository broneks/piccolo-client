import SwiftUI

struct PhotosView: View {
    @StateObject private var photosViewModel = PhotosViewModel()
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                if let photos = photosViewModel.photos {
                    ForEach(photos, id: \.id) { photo in
                        P6Photo(url: photo.url)
                    }
                }
            }
        }
        .padding(20)
        .task {
            await photosViewModel.fetchPhotos()
        }
    }
}

#Preview {
    PhotosView()
}

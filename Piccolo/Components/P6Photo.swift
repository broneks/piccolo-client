import Foundation
import SwiftUI

struct P6Photo: View {
    var url: String?

    var body: some View {
        AsyncImage(url: URL(string: url ?? "")) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let image):
                image
                    .resizable()
                    .scaledToFit()
            case .failure:
                Text("Failed to load image")
            @unknown default:
                Text("Unknown error")
            }
        }
    }
}

//
//  ContentView.swift
//  Piccolo
//
//  Created by Bronek on 2024-11-16.
//

import SwiftUI

struct ContentView: View {
    @State var photo: Photo?
    
    var body: some View {
        VStack(alignment: .leading) {
            if photo != nil {
                AsyncImage(url: URL(string: photo!.url)) { phase in
                                    switch phase {
                                    case .empty:
                                        ProgressView()  // Show loading spinner while the image is loading
                                    case .success(let image):
                                        image.resizable()  // Make the image resizable
                                            .scaledToFit()  // Maintain aspect ratio
                                            .frame(width: 200, height: 200)  // Set the desired frame size
                                    case .failure:
                                        Text("Failed to load image")  // Display an error message if loading fails
                                    @unknown default:
                                        Text("Unknown error")  // For unknown future cases
                                    }
                                }
            } else {
                Text("No data available")
            }
        }
        .padding(20.0)
        .task {
            do {
                let photoId = "b04651f7-c7c5-4848-aea3-72ffe65b48b5"
                photo = try await fetchPhoto(photoId: photoId)
            } catch {
                photo = nil
            }
        }
    }
    
    func fetchPhoto(photoId: String) async throws -> Photo {
        let url = URL(string: "http://localhost:8001/api/v1/photos/\(photoId)")!
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        request.setValue("Bearer <token>", forHTTPHeaderField: "Authorization")
        
        let (data, _) = try await URLSession.shared.data(for: request)
        return try JSONDecoder().decode(Photo.self, from: data)
    }
}

#Preview {
    ContentView()
}

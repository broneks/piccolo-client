//
//  ContentView.swift
//  Piccolo
//
//  Created by Bronek on 2024-11-16.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var photoViewModel = PhotoViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            if photoViewModel.photo != nil {
                AsyncImage(url: URL(string: photoViewModel.photo!.url)) { phase in
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
            } else {
                Text("No data available")
            }
        }
        .padding(20)
        .task {
            await photoViewModel.fetchPhoto(photoId: "b04651f7-c7c5-4848-aea3-72ffe65b48b5")
        }
    }
}

#Preview {
    ContentView()
}

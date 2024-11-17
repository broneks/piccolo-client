//
//  PhotoViewModel.swift
//  Piccolo
//
//  Created by Bronek on 2024-11-17.
//

import SwiftUI

class PhotoViewModel: ObservableObject {
    @Published var photo: Photo?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    func fetchPhoto(photoId: String) async {
        isLoading = true
        do {
            photo = try await APIService.shared.fetchData(method: "GET", path: "photos/\(photoId)")
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
}

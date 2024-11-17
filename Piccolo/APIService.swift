//
//  APIService.swift
//  Piccolo
//
//  Created by Bronek on 2024-11-17.
//

import Foundation

enum APIServiceError: Error {
    case invalidURL
}

class APIService {
    static let shared = APIService()
    private init() {}
    
    func fetchData<T: Decodable>(method: String, path: String) async throws -> T {
        let token = ""
        
        if let url = URL(string: "http://localhost:8001/api/v1/\(path)") {
            var request = URLRequest(url: url)
            request.httpMethod = method
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            
            let (data, _) = try await URLSession.shared.data(for: request)
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            
            return decodedData
        } else {
            throw APIServiceError.invalidURL
        }
    }
}

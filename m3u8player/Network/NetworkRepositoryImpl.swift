//
//  NetworkRepositoryImpl.swift
//  m3u8player
//
//  Created by Kaito Kitaya on 13.10.24.
//
import Foundation


struct NetworkRepositoryImpl: NetworkRepository {
    
    private let urlSession = URLSession.shared
    
    func checkIsValidURL(url: URL) async  -> Result<HTTPURLResponse, Error> {
        var request = URLRequest(url: url)
        request.httpMethod = "HEAD"
        guard let (_, response) = try? await urlSession.data(for: request) else {
            // TODO: Need to verify this error code is good or not
            return .failure(URLError(URLError.badURL))
        }
            if let httpResponse = response as? HTTPURLResponse {
                if (200...299).contains(httpResponse.statusCode) {
                    return .success(httpResponse)
                }
            } else {
                // TODO: Need to verify this error code is good or not
                return .failure(URLError(URLError.badURL))
            }
        // TODO: Need to verify this error code is good or not
        return .failure(URLError(URLError.badURL))
    }
}

// MARK: Mock Class
struct MockedNetworkRepository: NetworkRepository {
    func checkIsValidURL(url: URL) async -> Result<HTTPURLResponse, any Error> {
        return .success(HTTPURLResponse())
    }
}

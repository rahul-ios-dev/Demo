//
//  CustomService.swift
//  Demo
//
//  Created by Rahul Acharya on 22/10/24.
//

import Foundation

public typealias HTTPHeaders = [String: String]
public typealias JSON = [String: Any]

/// Primary API Service Object to get Rick and Morty data
final class APIClient {
    
    /// Shared Singleton instance
    static let shared = APIClient()
    
    /// privatised constructor
    private init() {}
    
    /// API Call
    /// - Parameters:
    ///   - request: Request Instance
    ///   - method: desire method
    ///   - headers: header
    ///   - body: only for post request
    ///   - type: The type of object we expect to get back
    ///   - completion: Call back with data or error
    public func executeRequest<T: Codable>(
        _ request: CustomURLRequest,
        method: RequestMethod,
        headers: HTTPHeaders? = nil,
        body: JSON? = nil,
        expecting type: T.Type,
        completion: @escaping (Result<T, Error>) -> Void) {
            
            guard let url = URL(string: request.rawValue) else { return }
            
            var urlRequest = URLRequest(url: url)
            
            urlRequest.httpMethod = method.rawValue
            urlRequest.allHTTPHeaderFields = headers
            
            
            if let body = body {
                urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: body)
            }
            
            URLSession.shared.dataTask(with: urlRequest) { data, _, error in
                guard let data = data,
                      error == nil else {
                    return
                }
                do {
                    let results = try JSONDecoder().decode(type.self, from: data)
                    completion(.success(results))
                }
                catch {
                    completion(.failure(error))
                }
            }.resume()
        }
}


enum RequestMethod: String {
    case get = "GET"
    case post = "POST"
}

enum CustomURLRequest: String {
    static let character = "https://rickandmortyapi.com/api/character"
}


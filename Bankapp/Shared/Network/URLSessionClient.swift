//
//  URLSessionClient.swift
//  Bankapp
//
//  Created by Erik Ciau on 22/08/23.
//
import Foundation

final class URLSessionClient: HttpClient {
    private var decoder: JSONDecoder = JSONDecoder()
    enum HTTPMethod: String {
        case get = "GET"
    }
    func get<T>(url: String) async throws -> (T, URLResponse) where T : Decodable, T : Encodable {
        try await performRequest(url: url, method: .get)
    }
    private func performRequest<T: Codable>(url: String, method: HTTPMethod) async throws -> (T, URLResponse) {
        guard let url = URL(string: url) else { fatalError() }
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = ["Content-Type":"application/json"]
        request.httpMethod = method.rawValue
        let (data, response) = try await URLSession.shared.data(for: request)
        let decode = try decoder.decode(T.self, from: data)
        return (decode, response)
    }
}

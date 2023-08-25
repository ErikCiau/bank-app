//
//  HttpClient.swift
//  Bankapp
//
//  Created by Erik Ciau on 22/08/23.
//
import Foundation
protocol HttpClient {
    func get<T: Codable>(url: String) async throws -> (T, URLResponse)
}

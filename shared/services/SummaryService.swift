//
//  SummaryService.swift
//  summary-chip
//
//  Created by Qiwei Li on 6/30/24.
//

import Foundation

enum Theme: String, Codable {
    case light
    case dark
}

struct FetchMetadataDto: Codable {
    let title: String
    let colors: [String]
    let description: String
    let theme: Theme
}

struct FetchMetadataBody: Codable {
    let url: String
}

struct FetchAISummaryDto: Codable {
    let summary: String
    let hightlights: [String]
}

struct FetchAISummaryBody: Codable {
    let url: String
    let language: Language?
}

struct SummaryService {
    let baseURL: String
    let apiKey: String

    func fetchMetadata(from url: URL) async throws -> FetchMetadataDto {
        var requestURL = URL(string: baseURL)!
        requestURL = requestURL.appending(path: "/api/generate/metadata")

        // add x-api-key header
        var request = URLRequest(url: requestURL)
        request.addValue(apiKey, forHTTPHeaderField: "x-api-key")
        request.httpMethod = "POST"
        request.httpBody = try JSONEncoder().encode(FetchMetadataBody(url: url.absoluteString))

        let (data, _) = try await URLSession.shared.data(for: request)
        return try JSONDecoder().decode(FetchMetadataDto.self, from: data)
    }

    func fetchAISummary(from url: URL, language: Language = .Original) async throws -> FetchAISummaryDto {
        var requestURL = URL(string: baseURL)!
        requestURL = requestURL.appending(path: "api/generate/summary/url")

        // add x-api-key header
        var request = URLRequest(url: requestURL)
        request.addValue(apiKey, forHTTPHeaderField: "x-api-key")
        request.httpMethod = "POST"
        request.httpBody = try JSONEncoder().encode(FetchAISummaryBody(url: url.absoluteString, language: language))

        let (data, _) = try await URLSession.shared.data(for: request)
        return try JSONDecoder().decode(FetchAISummaryDto.self, from: data)
    }
}

//
//  AISummaryModel.swift
//  SmartShare
//
//  Created by Qiwei Li on 6/30/24.
//

import Foundation

@Observable class SummaryModel {
    private let service: SummaryService

    var metadata: FetchMetadataDto?
    var summary: FetchAISummaryDto?

    var isLoadingMetadata = false
    var isLoadingSummary = false

    init(service: SummaryService) {
        self.service = service
    }

    @MainActor
    func fetchMetadata(from url: URL) async {
        isLoadingMetadata = true
        do {
            let metadata = try await service.fetchMetadata(from: url)
            self.metadata = metadata
        } catch {
            print("Error fetching metadata: \(error)")
        }
        isLoadingMetadata = false
    }

    @MainActor
    func fetchAISummary(from url: URL, language: Language) async {
        isLoadingSummary = true
        do {
            summary = try await service.fetchAISummary(from: url, language: language)
        } catch {
            print("Error fetching summary: \(error)")
        }
        isLoadingSummary = false
    }
}

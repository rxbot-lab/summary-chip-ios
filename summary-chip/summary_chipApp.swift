//
//  summary_chipApp.swift
//  summary-chip
//
//  Created by Qiwei Li on 6/27/24.
//

import SwiftUI

@main
struct summary_chipApp: App {
    @State var summaryModel: SummaryModel = .init(service: .init(baseURL: Secrets.url.rawValue, apiKey: Secrets.apiKey.rawValue))
    @State var previewModel: PreviewModel = .init()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(summaryModel)
                .environment(previewModel)
        }
    }
}

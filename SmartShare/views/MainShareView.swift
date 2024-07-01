//
//  MainShareView.swift
//  SmartShare
//
//  Created by Qiwei Li on 6/30/24.
//

import SwiftUI

struct MainShareView: View {
    let url: URL
    let extensionContext: NSExtensionContext?
    @State var summaryModel: SummaryModel = .init(service: .init(baseURL: Secrets.url.rawValue, apiKey: Secrets.apiKey.rawValue))
    @State var previewModel: PreviewModel = .init()

    var body: some View {
        NavigationStack {
            ShareView(url: url, language: .current)
                .navigationBarTitleDisplayMode(.inline)
                .environment(summaryModel)
                .environment(previewModel)
                .navigationTitle("Share Link")
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel") {
                            dismiss()
                        }
                        .tint(.red)
                    }
                }
        }
    }
}

extension MainShareView {
    func dismiss() {
        extensionContext?.completeRequest(returningItems: nil, completionHandler: nil)
    }
}

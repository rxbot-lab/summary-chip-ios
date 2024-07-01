//
//  PreviewModel.swift
//  summary-chip
//
//  Created by Qiwei Li on 6/30/24.
//

import Foundation

@Observable class PreviewModel {
    var options: SharePreviewCardOptions

    init() {
        self.options = .init(colors: [], title: nil, description: nil, summary: nil, highlights: nil, theme: .dark)
    }
}

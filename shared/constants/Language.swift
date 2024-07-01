//
//  Language.swift
//  summary-chip
//
//  Created by Qiwei Li on 6/30/24.
//

import Foundation

enum Language: String, CaseIterable, Identifiable, Codable {
    case ZH_CN = "ZH-CN"
    case Original = "Use Original language"
    case EN_US = "en_US"

    var id: String {
        return self.rawValue
    }

    static var current: Language {
        return .ZH_CN
    }
}

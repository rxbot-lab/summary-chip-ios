//
//  PreviewOptions.swift
//  SmartShare
//
//  Created by Qiwei Li on 6/28/24.
//

import Foundation

enum Section: String, CaseIterable, Identifiable {
    case Edit
    case Preview

    var id: Self { self }
}

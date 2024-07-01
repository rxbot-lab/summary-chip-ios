//
//  CheckListView.swift
//  summary-chip
//
//  Created by Qiwei Li on 6/30/24.
//

import SwiftUI

struct CheckListItem<Content: View>: View {
    let isChecked: Bool
    @ViewBuilder let content: Content

    var body: some View {
        HStack {
            Image(systemName: isChecked ? "checkmark.circle.fill" : "circle")
                .padding()
                .foregroundColor(isChecked ? .green : .gray)
            content
            Spacer()
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    CheckListItem(isChecked: true) {
        Text("Hello world")
    }
    .padding()
}

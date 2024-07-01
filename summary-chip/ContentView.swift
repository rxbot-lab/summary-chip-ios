//
//  ContentView.swift
//  summary-chip
//
//  Created by Qiwei Li on 6/27/24.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("url") private var url = ""
    @State private var show = false
    @State private var language: Language = .Original

    var body: some View {
        NavigationStack {
            Form {
                TextField(text: $url) {
                    Text("Enter a valid url")
                }
                .autocapitalization(.none)
                .textCase(.lowercase)

                Picker("Language", selection: $language) {
                    ForEach(Language.allCases) { lang in
                        Text(lang.rawValue)
                            .tag(lang)
                    }
                }

                Button {
                    show = true
                } label: {
                    Text("Go")
                }
                .disabled(URL(string: url) == nil)
            }
            .sheet(isPresented: $show) {
                if let url = URL(string: url) {
                    NavigationStack {
                        ShareView(url: url, language: language)
                            .navigationBarTitleDisplayMode(.inline)
                            .navigationTitle("Share Link")
                            .interactiveDismissDisabled()
                            .toolbar {
                                ToolbarItem(placement: .cancellationAction) {
                                    Button("Cancel") {
                                        show = false
                                    }
                                    .foregroundColor(.teal)
                                }
                            }
                    }
                }
            }
            .navigationTitle(Text("Link preview generator"))
        }
    }
}

#Preview {
    ContentView()
}

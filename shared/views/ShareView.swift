//
//  ShareView.swift
//  summary-chip
//
//  Created by Qiwei Li on 6/27/24.
//

import Foundation
import SwiftUI

struct ShareView: View {
    @State private var selection: Section = .Edit
    @Environment(SummaryModel.self) var summaryModel
    @Environment(PreviewModel.self) var previewModel
    @State private var showButton = true

    let url: URL
    let language: Language

    var body: some View {
        let previewCard = SharePreviewCard(options: previewModel.options)
        VStack {
            Picker("", selection: $selection) {
                ForEach(Section.allCases) { option in
                    Text(option.rawValue)
                        .tag(option.rawValue)
                }
            }
            .pickerStyle(.segmented)
            .padding(.horizontal, 5)

            if showButton {
                Image(systemName: "info.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(.blue)
                    .frame(width: 100, height: 100)
                    .padding()
                Text("Click the button below to generate a preview.")
                    .multilineTextAlignment(.center)
                Button {
                    showButton = false
                    Task {
                        // hide keyboard
                        await summaryModel.fetchMetadata(from: url)
                        if let metadata = summaryModel.metadata {
                            previewModel.options.colors = metadata.colors
                        }
                        await summaryModel.fetchAISummary(from: url, language: language)
                    }
                } label: {
                    Text("Generate")
                }
                .frame(maxWidth: .infinity)
                .buttonStyle(.borderedProminent)
                .padding()
                Spacer()
            }

            if selection == .Preview {
                if summaryModel.isLoadingMetadata || summaryModel.isLoadingSummary {
                    ProgressView()
                } else {
                    if !showButton {
                        previewCard
                            .frame(height: 300)
                            .padding()
                        Spacer()
                        if let uiImage = ImageRenderer(content: previewCard.frame(width: 500, height: 300)).uiImage {
                            ShareLink(item: Image(uiImage: uiImage), subject: Text(previewModel.options.subject(url: url)), message: Text(previewModel.options.message(url: url)), preview: SharePreview(previewModel.options.subject(url: url), image: Image(uiImage: uiImage))) {
                                Text("Share")
                                    .frame(maxWidth: .infinity)
                                    .foregroundStyle(.white)
                                    .padding()
                                    .background(previewModel.options.disabled ? .gray : .orange)
                                    .clipShape(.rect(cornerRadius: 10))
                                    .padding()
                            }
                            .disabled(previewModel.options.disabled)
                            .padding(.bottom, 50)
                        }
                    }
                }
            }

            if selection == .Edit {
                if summaryModel.isLoadingMetadata || summaryModel.isLoadingSummary {
                    ProgressView()
                    Spacer()
                } else {
                    Form {
                        if let metadata = summaryModel.metadata {
                            CheckListItem(isChecked: previewModel.options.title != nil) {
                                ListItem(title: "Title", description: metadata.title)
                            }
                            .onTapGesture {
                                if previewModel.options.title != nil {
                                    previewModel.options.title = nil
                                } else {
                                    previewModel.options.title = metadata.title
                                }
                            }

                            CheckListItem(isChecked: previewModel.options.description != nil) {
                                ListItem(title: "Description", description: metadata.description)
                            }
                            .onTapGesture {
                                if previewModel.options.description != nil {
                                    previewModel.options.description = nil
                                } else {
                                    previewModel.options.description = metadata.description
                                }
                            }
                        }

                        if let summary = summaryModel.summary {
                            CheckListItem(isChecked: previewModel.options.summary != nil) {
                                ListItem(title: "Summary", description: summary.summary)
                            }
                            .onTapGesture {
                                if previewModel.options.summary != nil {
                                    previewModel.options.summary = nil
                                } else {
                                    previewModel.options.summary = summary.summary
                                }
                            }

                            Text("Highlight")
                            ForEach(summary.hightlights, id: \.self) { highlight in
                                CheckListItem(isChecked: previewModel.options.highlights?.contains(highlight) ?? false) {
                                    Text(highlight)
                                }
                                .onTapGesture {
                                    if previewModel.options.highlights?.contains(highlight) ?? false {
                                        previewModel.options.highlights = nil
                                    } else {
                                        previewModel.options.highlights = [highlight]
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

extension ShareView {}

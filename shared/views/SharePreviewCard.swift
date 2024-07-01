//
//  SharePreviewCard.swift
//  summary-chip
//
//  Created by Qiwei Li on 6/30/24.
//

import SwiftUI

struct SharePreviewCardOptions {
    var colors: [String]
    var title: String?
    var description: String?
    var summary: String?
    var highlights: [String]?
    var theme: Theme

    func subject(url: URL) -> String {
        if summary != nil && highlights != nil {
            return "\(title ?? "") | \(url.absoluteString)"
        }

        if highlights != nil {
            return "\(highlights?.first ?? "") | \(url.absoluteString)"
        }

        if summary != nil {
            return "\(summary ?? "") | \(url.absoluteString)"
        }

        return ""
    }

    func message(url: URL) -> String {
        if summary != nil && highlights != nil {
            return "\(description ?? "") | \(url.absoluteString)"
        }

        if highlights != nil {
            return "\(title ?? "") | \(url.absoluteString)"
        }

        if summary != nil {
            return "\(title ?? "") | \(url.absoluteString)"
        }

        return "\(description ?? "") | \(url.absoluteString)"
    }

    var disabled: Bool {
        return false
    }
}

struct SharePreviewCard: View {
    let options: SharePreviewCardOptions

    var body: some View {
        let firstColor = options.colors.count > 0 ? Color(hex: options.colors[0]) : Color.gray
        let secondColor = options.colors.count > 1 ? Color(hex: options.colors[1]) : Color.gray

        ZStack {
            PreviewBackgroundCard(colors: options.colors)
            VStack {
                if options.summary == nil && options.highlights == nil {
                    if let title = options.title {
                        Text(title)
                            .multilineTextAlignment(.center)
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundStyle(.linearGradient(colors: [secondColor, firstColor],
                                                             startPoint: .topLeading,
                                                             endPoint: .bottomTrailing))
                            .shadow(color: options.theme == .light ? Color.black.opacity(0.8) : Color.white.opacity(0.8), radius: 5, x: 0, y: 2)
                            .padding()
                    }

                    if let description = options.description {
                        Text(description)
                            .font(.title2)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 10)
                            .fontWeight(.bold)
                            .foregroundStyle(options.theme == .light ? .black : .white)
                    }
                }

                if options.summary != nil || options.highlights != nil {
                    if let _ = options.title {
                        Spacer()
                    }

                    if options.highlights == nil {
                        if let summary = options.summary {
                            Text(summary)
                                .font(.title)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 10)
                                .fontWeight(.bold)
                                .shadow(color: options.theme == .light ? Color.white.opacity(0.8) : Color.black.opacity(0.8), radius: 5, x: 0, y: 2)
                                .foregroundStyle(options.theme == .light ? .black : .white)
                        }
                    } else {
                        if let firstHighlight = options.highlights?.first {
                            Text("\"\(firstHighlight)\"")
                                .font(.title)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 10)
                                .fontWeight(.bold)
                                .shadow(color: options.theme == .light ? Color.white.opacity(0.8) : Color.black.opacity(0.8), radius: 5, x: 0, y: 2)
                                .foregroundStyle(options.theme == .light ? .black : .white)
                        }
                    }

                    if let title = options.title {
                        Spacer()
                        HStack {
                            Spacer()
                            Text(title)
                                .fontWeight(.bold)
                                .foregroundStyle(options.theme == .light ? .black : .white)
                        }
                        .padding()
                    }
                }
            }
        }
        .clipShape(.rect(cornerRadius: 20))
    }
}

#Preview {
    SharePreviewCard(options: .init(colors: ["#104b8f",
                                             "#18673c",
                                             "#efcabc",
                                             "#9e8d80",
                                             "#5c3e34",
                                             "#dec5c6"],
                                    title: "BBC Headline", description: "Opinion: Ukraine’s new weapon against Russia? Lego | CNN", summary: "Opinion: Ukraine’s new weapon against Russia? Lego | CNN", highlights: nil, theme: .dark))
        .frame(height: 300)
        .padding()
}

#Preview {
    SharePreviewCard(options: .init(colors: ["#104b8f",
                                             "#18673c",
                                             "#efcabc",
                                             "#9e8d80",
                                             "#5c3e34",
                                             "#dec5c6"],
                                    title: "BBC Headline", description: "Opinion: Ukraine’s new weapon against Russia? Lego | CNN", summary: nil, highlights: nil, theme: .dark))
        .frame(height: 300)
        .padding()
}

#Preview {
    SharePreviewCard(options: .init(colors: ["#104b8f",
                                             "#18673c",
                                             "#efcabc",
                                             "#9e8d80",
                                             "#5c3e34",
                                             "#dec5c6"],
                                    title: "BBC Headline", description: "Opinion: Ukraine’s new weapon against Russia? Lego | CNN", summary: "Some", highlights: ["Some highlight"], theme: .dark))
        .frame(height: 300)
        .padding()
}

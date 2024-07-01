//
//  PreviewBackgroundCard.swift
//  SmartShare
//
//  Created by Qiwei Li on 6/30/24.
//

import SwiftUI

struct PreviewBackgroundCard: View {
    let colors: [String]

    var body: some View {
        if #available(iOS 18.0, *) {
            MeshGradient(width: 2, height: 3, points: [
                [0.0, 0.0], [0.0, 1.0],
                [0.5, 0.0], [0.5, 1.0],
                [1.0, 0.0], [1.0, 1.0]

            ], colors: colors.map { Color(hex: $0) })
        } else {
            let firstColor = colors.count > 0 ? Color(hex: colors[0]) : Color.gray
            let fifthColor = colors.count > 4 ? Color(hex: colors[4]) : Color.gray
            let sixthColor = colors.count > 5 ? Color(hex: colors[5]) : Color.gray
            LinearGradient(gradient: Gradient(colors: [firstColor, fifthColor]),
                           startPoint: .top,
                           endPoint: .bottom)
        }
    }
}

#Preview {
    PreviewBackgroundCard(colors: ["#104b8f",
                                   "#18673c",
                                   "#efcabc",
                                   "#9e8d80",
                                   "#5c3e34",
                                   "#dec5c6"])
}

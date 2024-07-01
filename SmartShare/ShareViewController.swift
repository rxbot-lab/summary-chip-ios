//
//  ShareViewController.swift
//  SmartShare
//
//  Created by Qiwei Li on 6/27/24.
//

import MobileCoreServices
import Social
import SwiftUI
import UIKit
import UniformTypeIdentifiers

class ShareViewController: UIViewController {
    override func viewDidLoad() {
        if let item = extensionContext?.inputItems.first as? NSExtensionItem,
           let attachments = item.attachments
        {
            for provider in attachments {
                if provider.hasItemConformingToTypeIdentifier(UTType.url.identifier) {
                    provider.loadItem(forTypeIdentifier: UTType.url.identifier, options: nil) { [weak self] url, _ in
                        if let url = url as? URL {
                            DispatchQueue.main.async {
                                self?.buildingWebpageSharingView(with: url)
                            }
                        }
                    }
                }
            }
        }
    }

    func buildingWebpageSharingView(with url: URL) {
        isModalInPresentation = true
        let hostingView = UIHostingController(rootView: MainShareView(url: url, extensionContext: extensionContext))
        hostingView.view.frame = view.frame
        view.addSubview(hostingView.view)
    }
}

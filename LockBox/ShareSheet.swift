//
//  ShareSheet.swift
//  LockBox
//
//  Created by Surya Vummadi on 21/06/25.
//

import Foundation
import SwiftUI

struct ShareSheet: UIViewControllerRepresentable {
    var activityItems: [Any]

    func makeUIViewController(context: Context) -> UIActivityViewController {
        UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}

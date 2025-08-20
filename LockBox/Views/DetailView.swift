//
//  DetailView.swift
//  LockBox
//
//  Created by Surya Vummadi on 21/06/25.
//

import Foundation
import SwiftUI

struct DetailView: View {
    @Binding var item: VaultItem

    @State private var isPasswordVisible = false
    @State private var openDocumentPreview = false
    @State private var isEditing = false

    var body: some View {
        Form {
            Text("\(Strings.titleLabel): \(item.title)").font(.headline)

            if item.isURL, let urlStr = item.urlString, let url = URL(string: urlStr) {
                Link(Strings.openWebsite, destination: url)
            } else if item.isDocument, let path = item.documentPath {
                Button(Strings.openDocument) {
                    openDocumentPreview = true
                }
            } else {
                if let user = item.username {
                    Text("\(Strings.username): \(user)")
                }

                if let number = item.number {
                    HStack {
                        if isPasswordVisible {
                            Text(number)
                        } else {
                            SecureField("", text: .constant(number)).disabled(true)
                        }

                        Spacer()

                        Button(action: {
                            isPasswordVisible.toggle()
                        }) {
                            Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
                        }
                    }
                }
            }
        }
        .navigationTitle(Strings.detailsTitle)
        .toolbar {
            Button(Strings.edit) {
                isEditing = true
            }
        }
        .sheet(isPresented: $openDocumentPreview) {
            if let path = item.documentPath {
                QuickLookPreview(url: URL(fileURLWithPath: path))
            }
        }
        .sheet(isPresented: $isEditing) {
            EditItemView(item: $item)
        }
    }
}

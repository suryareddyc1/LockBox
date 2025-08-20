//
//  EditItemView.swift
//  LockBox
//
//  Created by Surya Vummadi on 21/06/25.
//

import Foundation
import SwiftUI

struct EditItemView: View {
    @Binding var item: VaultItem
    @Environment(\.dismiss) var dismiss

    @State private var title: String
    @State private var username: String
    @State private var number: String
    @State private var isURL: Bool
    @State private var urlString: String
    @State private var isDocument: Bool
    @State private var documentPath: String?

    init(item: Binding<VaultItem>) {
        self._item = item
        _title = State(initialValue: item.wrappedValue.title)
        _username = State(initialValue: item.wrappedValue.username ?? "")
        _number = State(initialValue: item.wrappedValue.number ?? "")
        _isURL = State(initialValue: item.wrappedValue.isURL)
        _urlString = State(initialValue: item.wrappedValue.urlString ?? "")
        _isDocument = State(initialValue: item.wrappedValue.isDocument)
        _documentPath = State(initialValue: item.wrappedValue.documentPath)
    }

    var body: some View {
        NavigationView {
            Form {
                TextField(Strings.titleLabel, text: $title)
                Toggle("Is Website?", isOn: $isURL)

                if isURL {
                    TextField("URL", text: $urlString)
                } else {
                    TextField(Strings.username, text: $username)
                    TextField(Strings.passwordNumber, text: $number)
                }

                if isDocument {
                    Text("Linked document cannot be edited here.")
                        .foregroundColor(.gray)
                }
            }
            .navigationTitle(Strings.edit)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(Strings.cancel) {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button(Strings.save) {
                        item.title = title
                        item.username = isURL ? nil : username
                        item.number = isURL ? nil : number
                        item.isURL = isURL
                        item.urlString = isURL ? urlString : nil
                        item.isDocument = isDocument
                        item.documentPath = documentPath

                        var allItems = loadItems()
                        if let index = allItems.firstIndex(where: { $0.id == item.id }) {
                            allItems[index] = item
                            saveItems(allItems)
                        }

                        dismiss()
                    }
                }
            }
        }
    }
}

//
//  HomeView.swift
//  LockBox
//
//  Created by Surya Vummadi on 21/06/25.
//

import Foundation
import SwiftUI

struct HomeView: View {
    @State private var items: [VaultItem] = loadItems()
    @State private var searchText = ""
    @State private var showPicker = false
    @State private var shareDoc: VaultItem?
    @State private var previewDoc: VaultItem?

    var body: some View {
        NavigationView {
            ZStack {
                if filteredItems.isEmpty {
                    VStack(spacing: 12) {
                        Image(systemName: "arrow.up.right.circle")
                            .font(.system(size: 60))
                            .foregroundColor(.gray)
                        Text(Strings.addButtonHint)
                            .font(.headline)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                    }
                } else {
                    List {
                        // 🔗 Saved URLs Section
                        if !filteredItems.filter({ $0.isURL }).isEmpty {
                            Section(header: Text(Strings.savedURLs)) {
                                ForEach(filteredItems) { item in
                                    if item.isURL,
                                       let index = items.firstIndex(where: { $0.id == item.id }) {
                                        NavigationLink(destination: ProtectedDetailView(item: $items[index])) {
                                            Label(item.title, systemImage: "link")
                                        }
                                    }
                                }
                                .onDelete { indexSet in
                                    deleteItems(indexSet: indexSet, in: filteredItems.filter { $0.isURL })
                                }
                            }
                        }

                        // 🔐 Passwords Section
                        if !filteredItems.filter({ !$0.isURL }).isEmpty {
                            Section(header: Text(Strings.securedItems)) {
                                ForEach(filteredItems) { item in
                                    if !item.isURL,
                                       let index = items.firstIndex(where: { $0.id == item.id }) {
                                        HStack {
                                            NavigationLink(destination: ProtectedDetailView(item: $items[index])) {
                                                Label(item.title, systemImage: item.isDocument ? "doc.text" : "lock")
                                            }

                                            Spacer()

                                            if item.isDocument {
                                                Button(action: {
                                                    shareDoc = item
                                                }) {
                                                    Image(systemName: "square.and.arrow.up")
                                                }
                                            }
                                        }
                                    }
                                }
                                .onDelete { indexSet in
                                    deleteItems(indexSet: indexSet, in: filteredItems.filter { !$0.isURL })
                                }

//                                Button(action: { showPicker = true }) {
//                                    Label("Upload Document", systemImage: "plus")
//                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle(Strings.appTitle)
            .toolbar {
                NavigationLink(destination: AddItemView(onSave: { newItem in
                    items.append(newItem)
                    saveItems(items)
                })) {
                    Image(systemName: "plus")
                }
            }
            .searchable(text: $searchText)
            .fileImporter(
                isPresented: $showPicker,
                allowedContentTypes: [.pdf, .image],
                allowsMultipleSelection: false
            ) { result in
                switch result {
                case .success(let urls):
                    if let fileURL = urls.first,
                       let newItem = saveDocumentAndCreateVaultItem(url: fileURL) {
                        items.append(newItem)
                        saveItems(items)
                    }
                case .failure(let error):
                    print("File import error: \(error)")
                }
            }
            .sheet(item: $shareDoc) { doc in
                if let path = doc.documentPath {
                    ShareSheet(activityItems: [URL(fileURLWithPath: path)])
                }
            }
            .sheet(item: $previewDoc) { doc in
                if let path = doc.documentPath {
                    QuickLookPreview(url: URL(fileURLWithPath: path))
                }
            }
        }
    }

    // 🔍 Search logic
    var filteredItems: [VaultItem] {
        if searchText.isEmpty { return items }
        return items.filter {
            $0.title.localizedCaseInsensitiveContains(searchText) ||
            ($0.username?.localizedCaseInsensitiveContains(searchText) ?? false) ||
            ($0.number?.localizedCaseInsensitiveContains(searchText) ?? false) ||
            ($0.urlString?.localizedCaseInsensitiveContains(searchText) ?? false)
        }
    }

    func deleteItems(indexSet: IndexSet, in filtered: [VaultItem]) {
        let idsToDelete: [UUID] = indexSet.compactMap { index -> UUID? in
            guard filtered.indices.contains(index) else { return nil }
            return filtered[index].id
        }

        for id in idsToDelete {
            if let realIndex = items.firstIndex(where: { $0.id == id }) {
                let item = items[realIndex]

                if item.isDocument, let path = item.documentPath {
                    try? FileManager.default.removeItem(atPath: path)
                }

                items.remove(at: realIndex)
            }
        }

        saveItems(items)
    }
}

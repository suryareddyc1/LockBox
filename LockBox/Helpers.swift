//
//  File.swift
//  LockBox
//
//  Created by Surya Vummadi on 20/06/25.
//

import Foundation
import SwiftUI

func saveItems(_ items: [VaultItem]) {
    if let data = try? JSONEncoder().encode(items) {
        KeychainHelper.shared.save(data, service: "SecureVault", account: "vault_data")
    }
}

func loadItems() -> [VaultItem] {
    guard let data = KeychainHelper.shared.read(service: "SecureVault", account: "vault_data"),
          let items = try? JSONDecoder().decode([VaultItem].self, from: data) else {
        return []
    }
    return items
}

func saveDocument(url: URL) -> VaultDocument? {
    let fileManager = FileManager.default
    let docsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
    let destination = docsURL.appendingPathComponent(url.lastPathComponent)

    do {
        if fileManager.fileExists(atPath: destination.path) {
            try fileManager.removeItem(at: destination)
        }
        try fileManager.copyItem(at: url, to: destination)
        return VaultDocument(name: url.lastPathComponent, path: destination.path)
    } catch {
        print("Failed to save file: \(error)")
        return nil
    }
}

func loadDocuments() -> [VaultDocument] {
    let fileManager = FileManager.default
    let docsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]

    do {
        let files = try fileManager.contentsOfDirectory(atPath: docsURL.path)
        return files.map {
            VaultDocument(name: $0, path: docsURL.appendingPathComponent($0).path)
        }
    } catch {
        return []
    }
}


func saveDocumentAndCreateVaultItem(url: URL) -> VaultItem? {
    let fileManager = FileManager.default
    let docsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
    let destination = docsURL.appendingPathComponent(url.lastPathComponent)

    do {
        if fileManager.fileExists(atPath: destination.path) {
            try fileManager.removeItem(at: destination)
        }
        try fileManager.copyItem(at: url, to: destination)

        return VaultItem(
            title: url.lastPathComponent,
            isDocument: true,
            documentPath: destination.path
        )
    } catch {
        print("Failed to save file: \(error)")
        return nil
    }
}

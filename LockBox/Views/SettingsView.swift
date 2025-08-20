//
//  SettingsView.swift
//  LockBox
//
//  Created by Surya Vummadi on 21/06/25.
//

import Foundation
import SwiftUI

struct SettingsView: View {
    @State private var showConfirmation = false

    var body: some View {
        NavigationView {
            Form {
                Section {
                    Button(role: .destructive) {
                        showConfirmation = true
                    } label: {
                        Label(Strings.deleteAllData, systemImage: "trash")
                    }
                }
            }
            .navigationTitle(Strings.settingsTitle)
            .alert(Strings.deleteWarningTitle, isPresented: $showConfirmation) {
                Button(Strings.deleteButton, role: .destructive) {
                    deleteAllVaultData()
                    
                    // exit the app
                    exit(0)
                }
                Button(Strings.cancel, role: .cancel) {}
            } message: {
                Text(Strings.deleteWarningMessage)
            }
        }
        
    }
    func deleteAllVaultData() {
        // Load existing data
        var items = loadItems()

        // Delete documents from disk
        for item in items where item.isDocument {
            if let path = item.documentPath {
                try? FileManager.default.removeItem(atPath: path)
            }
            
        }

        // Clear stored items
        items = []
        saveItems(items)
    }
   
}

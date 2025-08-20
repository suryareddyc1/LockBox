//
//  AddItemView.swift
//  LockBox
//
//  Created by Surya Vummadi on 21/06/25.
//

import Foundation
import SwiftUI

struct AddItemView: View {
    @Environment(\.dismiss) var dismiss
    @State private var title = ""
    @State private var username = ""
    @State private var number = ""
    @State private var isURL = false
    @State private var urlString = ""

    let onSave: (VaultItem) -> Void

    var body: some View {
        Form {
            TextField(Strings.titleLabel, text: $title)

            Toggle(Strings.isThisWebsiteURL, isOn: $isURL)

            if isURL {
                TextField(Strings.url, text: $urlString)
                    .autocapitalization(.none)
                       .disableAutocorrection(true)
            } else {
                TextField(Strings.username, text: $username)
                    .autocapitalization(.none)
                       .disableAutocorrection(true)
                SecureField(Strings.passwordNumber, text: $number)
                    .autocapitalization(.none)
                       .disableAutocorrection(true)
                    
            }
        }
        .navigationTitle(Strings.addItem)
        .toolbar {
            Button(Strings.save) {
                let item = VaultItem(
                    title: title,
                    username: isURL ? nil : username,
                    number: isURL ? nil : number,
                    isURL: isURL,
                    urlString: isURL ? urlString : nil
                )
                onSave(item)
                dismiss()
            }
        }
    }
}

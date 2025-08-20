//
//  ProtectedDetailView.swift
//  LockBox
//
//  Created by Surya Vummadi on 21/06/25.
//

import Foundation
import SwiftUI
import LocalAuthentication

struct ProtectedDetailView: View {
    @Binding var item: VaultItem
    @State private var isUnlocked = false
    @State private var showError = false

    var body: some View {
        Group {
            if isUnlocked {
                DetailView(item: $item)
            } else {
                ProgressView("Authenticating...")
                    .onAppear(perform: authenticate)
            }
        }
        .alert(Strings.authFailed, isPresented: $showError) {
            Button(Strings.retry, action: authenticate)
        }
    }

    func authenticate() {
        let context = LAContext()
        let reason = "Authenticate to view secure content"
        var error: NSError?

        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) {
            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason) { success, _ in
                DispatchQueue.main.async {
                    isUnlocked = success
                    if !success { showError = true }
                }
            }
        } else {
            showError = true
        }
    }
}

//
//  AuthManager.swift
//  LockBox
//
//  Created by Surya Vummadi on 21/06/25.
//

import Foundation
import LocalAuthentication


class AuthManager: ObservableObject {
    @Published var isUnlocked = false

    func authenticate() {
        let context = LAContext()
        var error: NSError?

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Unlock SecureVault"

            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, _ in
                DispatchQueue.main.async {
                    self.isUnlocked = success
                }
            }
        }
    }
}

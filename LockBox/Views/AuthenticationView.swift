//
//  AuthenticationView.swift
//  LockBox
//
//  Created by Surya Vummadi on 21/06/25.
//

import Foundation
import SwiftUI

struct AuthenticationView: View {
    @StateObject var auth = AuthManager()

    var body: some View {
        VStack {
            if auth.isUnlocked {
                HomeView()
            } else {
                Button("Unlock SecureVault") {
                    auth.authenticate()
                }
                .padding()
            }
        }
    }
}

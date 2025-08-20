//
//  VaultDocument.swift
//  LockBox
//
//  Created by Surya Vummadi on 21/06/25.
//

import Foundation

struct VaultDocument: Identifiable, Codable {
    var id = UUID()
    var name: String
    var path: String
}

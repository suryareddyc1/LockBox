//
//  ValultItem.swift
//  LockBox
//
//  Created by Surya Vummadi on 21/06/25.
//

import Foundation

struct VaultItem: Identifiable, Codable {
    var id = UUID()
    var title: String
    var username: String?
    var number: String?
    var isURL: Bool = false
    var urlString: String?
    var isDocument: Bool = false            // ✅ NEW
    var documentPath: String? = nil         // ✅ NEW
}

//
//  Strings.swift
//  LockBox
//
//  Created by Surya Vummadi on 21/06/25.
//

import Foundation

enum Strings {
    static var appTitle: String { localized("securevault_title") }
    static var addButtonHint: String { localized("add_button_hint") }
    static var savedURLs: String { localized("saved_urls") }
    static var passwords: String { localized("passwords") }
    static var uploadDocument: String { localized("upload_document") }
    static var openWebsite: String { localized("open_website") }
    static var openDocument: String { localized("open_document") }
    static var username: String { localized("username") }
    static var passwordNumber: String { localized("password_number") }
    static var titleLabel: String { localized("title_label") }
    static var cancel: String { localized("cancel") }
    static var save: String { localized("save") }
    static var edit: String { localized("edit") }
    static var authFailed: String { localized("authentication_failed") }
    static var retry: String { localized("retry") }
    static var detailsTitle: String { localized("details_title") }
    static var isWebsite: String { localized("is_website") }
    static var url: String { localized("url") }
    static var addItem: String { localized("add_item") }
    static var settingsTitle: String { localized("settings_title") }
    static var deleteAllData: String { localized("delete_all_data") }
    static var deleteWarningTitle: String { localized("delete_warning_title") }
    static var deleteWarningMessage: String { localized("delete_warning_message") }
    static var deleteButton: String { localized("delete_button") }
    static var cancelButton: String { localized("cancel_button") }
    static var icloudSyncSection: String { localized("icloud_sync_section") }
    static var backupToiCloud: String { localized("backup_to_icloud") }
    static var restoreFromiCloud: String { localized("restore_from_icloud") }
    static var syncStatusSynced: String { localized("sync_status_synced") }
    static var syncStatusSyncing: String { localized("sync_status_syncing") }
    static var syncStatusError: String { localized("sync_status_error") }
    static var refreshNow: String { localized("refresh_now") }
    static var editItemTitle: String { localized("edit_item_title") }
    static var isThisWebsiteURL: String { localized("is_this_website_url") }
    static var securedItems: String { localized("Secured_Items") }
    
    // MARK: - Utility
    private static func localized(_ key: String) -> String {
        NSLocalizedString(key, comment: "")
    }
}

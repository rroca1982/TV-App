//
//  String+Helpers.swift
//  TV App
//
//  Created by Rodolfo Roca on 9/25/20.
//  Copyright © 2020 Rodolfo Roca. All rights reserved.
//

import Foundation

extension String {
    func localized(bundle: Bundle = .main, tableName: String = "Localizable") -> String {
        return NSLocalizedString(self, tableName: tableName, value: "**\(self)**", comment: "")
    }
    
    func fromHTMLToAttributedString() -> NSAttributedString {
            guard let data = data(using: .utf8) else { return NSAttributedString() }
            do {
                return try NSAttributedString(
                    data: data,
                    options: [
                        NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html,
                        NSAttributedString.DocumentReadingOptionKey.characterEncoding: String.Encoding.utf8.rawValue
                    ],
                    documentAttributes: nil
                ).trailingNewlineChopped
            } catch {
                return NSAttributedString()
            }
        }
    }

    extension NSAttributedString {
        var trailingNewlineChopped: NSAttributedString {
            if self.string.hasSuffix("\n") {
                return self.attributedSubstring(from: NSRange(location: 0, length: self.length - 1))
            } else {
                return self
            }
        }
    }

//
//  convertIdentifierToCode.swift
//  story2code
//
//  Created by Blazej Sleboda on 17/07/2025.
//


func convertIdentifierToCode(_ identifier: String?) -> String? {
    guard let identifier, !identifier.isEmpty else { return nil }
    return ".ibIdentifier(\"" + identifier + "\")"
}

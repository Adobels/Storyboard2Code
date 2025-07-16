//
//  parseTextInputTraits.swift
//  story2code
//
//  Created by Blazej Sleboda on 15/07/2025.
//

import StoryboardDecoder

func parseTextInputTraits(_ textInputTraits: TextField.TextInputTraits?) -> [String] {
    guard let textInputTraits else { return [] }
    var result = [String]()
    if let value = textInputTraits.textContentType { // In IB: Content Type
        result.append("$0.textContentType = .\(value)")
    }
    if let value = textInputTraits.autocapitalizationType { // In IB: Capitalization
        result.append("$0.autocapitalizationType = .\(value)")
    }
    if let value = textInputTraits.autocorrectionType {
        result.append("$0.autocorrectionType = .\(value)")
    }
    if let value = textInputTraits.spellCheckingType {
        result.append("$0.spellCheckingType = .\(value)")
    }
    if let value = textInputTraits.keyboardType {
        result.append("$0.keyboardType = .\(value)")
    }
    if let value = textInputTraits.keyboardAppearance {
        result.append("$0.keyboardAppearance = .\(value)")
    }
    if let value = textInputTraits.returnKeyType {
        result.append("$0.returnKeyType = .\(value)")
    }
    if let value = textInputTraits.smartDashesType {
        result.append("$0.smartDashesType = .\(value)")
    }
    if let value = textInputTraits.smartInsertDeleteType {
        result.append("$0.smartInsertDeleteType = .\(value)")
    }
    if let value = textInputTraits.smartQuotesType {
        result.append("$0.smartQuotesType = .\(value)")
    }
    if let value = textInputTraits.enablesReturnKeyAutomatically {
        result.append("$0.enablesReturnKeyAutomatically = \(value)")
    }
    if let value = textInputTraits.secureTextEntry {
        result.append("$0.isSecureTextEntry = \(value)")
    }
    return result
}

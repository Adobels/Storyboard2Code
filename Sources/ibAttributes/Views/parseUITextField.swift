//
//  parseUITextField.swift
//  story2code
//
//  Created by Blazej Sleboda on 30/06/2025.
//

import StoryboardDecoder

func parseUITextField(of textField: TextField) -> [String] {
    var result = [String]()
    if let text = textField.text {
        result.append("$0.text = \"\(text)\"")
    }
    if let value = textField.textColor {
        result.append("$0.textColor = \(colorToCode(value))")
    }
    if let value = textField.fontDescription {
        result.append("$0.font = \(fontDescriptionToCode(value))")
    }
    if let value = textField.adjustsFontForContentSizeCategory {
        result.append("$0.adjustsFontForContentSizeCategory")
    }
    if let value = textField.textAlignment {
        result.append("$0.textAlignment = .\(value)")
    }
    if let value = textField.placeholder {
        result.append("$0.placeholder = .\(value)")
    }
    // missing background image property
    // missing background disabled image property
    
    if let value = textField.borderStyle {
        result.append("$0.borderStyle = .\(value)")
    }
    if let value = textField.clearButtonMode {
        result.append("$0.clearButtonMode = .\(value)")
    }
    if let value = textField.clearsOnBeginEditing {
        result.append("$0.clearsOnBeginEditing = \(value)")
    }
    if let value = textField.minimumFontSize {
        result.append("$0.minimumFontSize = \(value)")
    }
    if let value = textField.adjustsFontSizeToFit {
        result.append("$0.adjustsFontSizeToFit = \(value)")
    }
    if let value = textField.sizingRule {
        result.append("$0.sizingRule = \(value)")
    }
    if let value = textField.textInputTraits?.textContentType { // In IB: Content Type
        result.append("$0.textContentType = \(value)")
    }
    if let value = textField.textInputTraits?.autocapitalizationType { // In IB: Capitalization
        result.append("$0.autocapitalizationType = .\(value)")
    }
    if let value = textField.textInputTraits?.autocorrectionType {
        result.append("$0.autocorrectionType = \(value)")
    }
    if let value = textField.textInputTraits?.spellCheckingType {
        result.append("$0.spellCheckingType = \(value)")
    }
    if let value = textField.textInputTraits?.keyboardType {
        result.append("$0.spellCheckingType = \(value)")
    }
    if let value = textField.textInputTraits?.keyboardAppearance {
        result.append("$0.keyboardAppearance = \(value)")
    }
    if let value = textField.textInputTraits?.returnKeyType {
        result.append("$0.returnKeyType = \(value)")
    }
    if let value = textField.textInputTraits?.smartDashesType {
        result.append("$0.smartDashesType = \(value)")
    }
    if let value = textField.textInputTraits?.smartInsertDeleteType {
        result.append("$0.smartInsertDeleteType = \(value)")
    }
    if let value = textField.textInputTraits?.smartQuotesType {
        result.append("$0.smartQuotesType = \(value)")
    }
    if let value = textField.textInputTraits?.enablesReturnKeyAutomatically {
        result.append("$0.enablesReturnKeyAutomatically = \(value)")
    }
    if let value = textField.textInputTraits?.secureTextEntry {
        result.append("$0.secureTextEntry = \(value)")
    }
    // -- UIControl
    if let value = textField.contentHorizontalAlignment {
        result.append("$0.contentHorizontalAlignment = .\(value)")
    }
    if let value = textField.contentVerticalAlignment {
        result.append("$0.contentVerticalAlignment = .\(value)")
    }
    // missing support for Menu : Shows as Primary Action
    if let value = textField.isSelected {
        result.append("$0.isSelected = \(value)")
    }
    if let value = textField.isEnabled {
        result.append("$0.isEnabled = \(value)")
    }
    if let value = textField.isHighlighted {
        result.append("$0.isHighlighted = \(value)")
    }
    // missing support for Tooltip
    return result
}


struct TextFieldWrapper {

    let textField: TextField

    init(with textField: TextField) {
        self.textField = textField
    }

    var textContentType: String? { textField.textInputTraits?.textContentType }
}

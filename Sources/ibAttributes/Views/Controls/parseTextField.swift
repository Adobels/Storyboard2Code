//
//  parseTextField.swift
//  story2code
//
//  Created by Blazej Sleboda on 30/06/2025.
//

import StoryboardDecoder

func parseTextField(of textField: TextField) -> [String] {
    var result = [String]()
    result.append(contentsOf: parseViewProtocol(of: textField))
    result.append(contentsOf: parseControlProtocol(of: textField))
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
        result.append("$0.placeholder = \"\(value)\"")
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
        result.append("$0.adjustsFontSizeToFitWidth = \(value)")
    }
    if let value = textField.sizingRule {
        result.append("$0.sizingRule = \(value)")
    }
    result.append(contentsOf: parseTextInputTraits(textField.textInputTraits))
    if let value = textField.allowsEditingTextAttributes {
        result.append("$0.allowsEditingTextAttributes = \(value)")
    }
    return result
}

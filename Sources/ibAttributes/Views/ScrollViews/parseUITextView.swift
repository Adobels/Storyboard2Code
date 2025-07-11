//
//  parseUITextView.swift
//  story2code
//
//  Created by Blazej Sleboda on 27/06/2025.
//

import StoryboardDecoder

func parseUITextView(of textView: TextView) -> [String] {
    var arrStrings = [String]()
    arrStrings.append(contentsOf: parseView(of: textView))
    if let view = textView as? ScrollViewProtocol {
        arrStrings.append(contentsOf: parseScrollView(of: view))
    } else { fatalError() }
    // Text View: Not all members are parsed
    if let text = textView.text {
        arrStrings.append("$0.text = \"\(text)\"")
    }
    if let textColor = textView.textColor {
        arrStrings.append("$0.textColor = \(colorToCode(textColor))")
    }
    if let fontDescription = textView.fontDescription {
        arrStrings.append("$0.font = \(fontDescriptionToCode(fontDescription))")
    }
    if let textAlignment = textView.textAlignment {
        arrStrings.append("$0.textAlignment = .\(textAlignment)")
    }
    if let value = textView.textInputTraits?.textContentType { // In IB: Content Type
        arrStrings.append("$0.textContentType = \(value)")
    }
    if let value = textView.textInputTraits?.autocapitalizationType { // In IB: Capitalization
        arrStrings.append("$0.autocapitalizationType = .\(value)")
    }
    if let value = textView.textInputTraits?.autocorrectionType {
        arrStrings.append("$0.autocorrectionType = \(value)")
    }
    if let value = textView.textInputTraits?.spellCheckingType {
        arrStrings.append("$0.spellCheckingType = \(value)")
    }
    if let value = textView.textInputTraits?.keyboardType {
        arrStrings.append("$0.spellCheckingType = \(value)")
    }
    if let value = textView.textInputTraits?.keyboardAppearance {
        arrStrings.append("$0.keyboardAppearance = \(value)")
    }
    if let value = textView.textInputTraits?.returnKeyType {
        arrStrings.append("$0.returnKeyType = \(value)")
    }
    if let value = textView.textInputTraits?.smartDashesType {
        arrStrings.append("$0.smartDashesType = \(value)")
    }
    if let value = textView.textInputTraits?.smartInsertDeleteType {
        arrStrings.append("$0.smartInsertDeleteType = \(value)")
    }
    if let value = textView.textInputTraits?.smartQuotesType {
        arrStrings.append("$0.smartQuotesType = \(value)")
    }
    if let value = textView.textInputTraits?.enablesReturnKeyAutomatically {
        arrStrings.append("$0.enablesReturnKeyAutomatically = \(value)")
    }
    if let value = textView.textInputTraits?.secureTextEntry {
        arrStrings.append("$0.secureTextEntry = \(value)")
    }
    return arrStrings
}

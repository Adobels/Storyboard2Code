//
//  parseUITextView.swift
//  story2code
//
//  Created by Blazej Sleboda on 27/06/2025.
//

import StoryboardDecoder

func parseUITextView(of textView: TextView) -> [String] {
    var arrStrings = [String]()
    arrStrings.append(contentsOf: parseViewProtocol(of: textView))
    arrStrings.append(contentsOf: parseScrollViewProtocol(of: textView))
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
    if let value = textView.textAlignment, value != "natural" {
        arrStrings.append("$0.textAlignment = .\(value)")
    }
    arrStrings.append(contentsOf: parseTextInputTraits(textView.textInputTraits))
    return arrStrings
}

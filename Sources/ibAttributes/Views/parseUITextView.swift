//
//  parseUITextView.swift
//  story2code
//
//  Created by Blazej Sleboda on 27/06/2025.
//

import StoryboardDecoder

func parseUITextView(of textView: TextView) -> [String] {
    var arrStrings = [String]()
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
    // Scroll View: Not all members are parsed
    if let value = textView.showsHorizontalScrollIndicator {
        arrStrings.append("$0.showsHorizontalScrollIdicator = \(value)")
    }
    if let value = textView.showsVerticalScrollIndicator {
        arrStrings.append("$0.showsVerticalScrollIndicator = \(value)")
    }
    return arrStrings
}

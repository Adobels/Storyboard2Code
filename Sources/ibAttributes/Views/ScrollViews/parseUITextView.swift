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
    return arrStrings
}

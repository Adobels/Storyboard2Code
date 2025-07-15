//
//  lineBreakModeToCode.swift
//  story2code
//
//  Created by Blazej Sleboda on 15/07/2025.
//

func lineBreakModeToCode(_ value: String?) -> String? {
    guard let value else { return nil }
    guard !value.isEmpty else { return nil }
    let codePropertyLineBreakMode: String = switch value {
    case "wordWrap": "byWordWrapping"
    case "characterWrap": "byCharWrapping"
    case "clip": "byClipping"
    case "headTruncation": "byTruncatingHead"
    case "tailTruncation": "byTruncatingTail"
    case "middleTruncation": "byTruncatingMiddle"
    default: fatalError()
    }
    return codePropertyLineBreakMode
}

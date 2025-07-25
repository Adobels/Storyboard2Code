//
//  parseButton.swift
//  story2code
//
//  Created by Blazej Sleboda on 11/07/2025.
//

import StoryboardDecoder

func parseButton(of view: Button) -> [String] {
    var result: [String] = []
    result.append(contentsOf: parseViewProtocol(of: view))
    result.removeAll(where: { $0 == "$0.backgroundColor = Colors.black" })
    result.append(contentsOf: parseControlProtocol(of: view))
    if let rawValue = view.lineBreakMode, rawValue != "middleTruncation", let value = lineBreakModeToCode(rawValue) {
        result.append("$0.titleLabel?.lineBreakMode = .\(value)")
    }
    if let value = view.fontDescription {
        if view.customClass == "LargeButton" { } else { // The Project LargeButton 
            result.append("$0.titleLabel?.font = \(fontDescriptionToCode(value))")
        }
    }
    if let value = view.showsTouchWhenHighlighted {
        result.append("$0.showsTouchWhenHighlighted = \(value)")
    }
    if let value = view.adjustsImageWhenHighlighted {
        result.append("$0.adjustsImageWhenHighlighted = \(value)")
    }
    view.state?.forEach { state in
        if let value = state.title, let stateKey = state.key {
            result.append("$0.setTitle(\"\(value)\", for: .\(stateKey))")
        }
        if let value = state.image, let stateKey = state.key {
            result.append("$0.setImage(.\(snakeToCamelCase(value)), for: .\(stateKey))")
        }
        if let value = state.backgroundImage, let stateKey = state.key {
            result.append("$0.setBackgroundImage(.\(snakeToCamelCase(value)), for: .\(stateKey))")
        }
        if let value = state.titleColor, let stateKey = state.key {
            result.append("$0.setTitleColor(\(value), for: .\(stateKey))")
        }
        if let value = state.titleShadowColor, let stateKey = state.key {
            result.append("$0.setTitleShadowColor(\(value), for: .\(stateKey))")
        }
        if let value = state.color { fatalError() }
    }
    if let value = view.titleEdgeInsets, let value = parseInset(value)  {
        result.append("$0.titleEdgeInsets = \(value)")
    }
    if let value = view.imageEdgeInsets, let value = parseInset(value)  {
        result.append("$0.imageEdgeInsets = \(value)")
    }
    if let value = view.contentEdgeInsets, let value = parseInset(value)  {
        result.append("$0.contentEdgeInsets = \(value)")
    }
    return result
}

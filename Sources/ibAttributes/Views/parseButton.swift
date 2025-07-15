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
    result.append(contentsOf: parseControlProtocol(of: view))
    if let value = view.lineBreakMode {
        result.append("$0.lineBreakMode = \(value)")
    }
    if let value = view.showsTouchWhenHighlighted {
        result.append("$0.showsTouchWhenHighlighted = \(value)")
    }
    if let value = view.adjustsImageWhenHighlighted {
        result.append("$0.adjustsImageWhenHighlighted = \(value)")
    }
    view.state?.forEach { state in
        if let value = state.title {
            result.append("$0.setTitle(\(value), for: .\(state.key)")
        }
        if let value = state.image {
            result.append("$0.setImage(\(value), for: .\(state.key)")
        }
        if let value = state.backgroundImage {
            result.append("$0.setBackgroundImage(\(value), for: .\(state.key)")
        }
        if let value = state.titleColor {
            result.append("$0.setTitleColor(\(value), for: .\(state.key)")
        }
        if let value = state.titleShadowColor {
            result.append("$0.setTitleShadowColor(\(value), for: .\(state.key)")
        }
        if let value = state.color { fatalError() }
    }
    if let value = view.fontDescription {
        result.append("$0.titleLabel.font = .\(fontDescriptionToCode(value))")
    }
    if let value = view.imageEdgeInsets {
        result.append("$0.imageEdgeInsets = \(value)")
    }
    if let value = view.contentEdgeInsets {
        result.append("$0.contentEdgeInsets = \(value)")
    }
    if let value = view.imageEdgeInsets {
        result.append("$0.imageEdgeInsets = \(value)")
    }
    return result
}

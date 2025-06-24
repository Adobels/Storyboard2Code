//
//  File.swift
//  story2code
//
//  Created by Blazej Sleboda on 02/04/2025.
//

import StoryboardDecoder

func parseIbAttributes(of uiView: ViewProtocol) -> [String] {
    var attributes: [String] = []
    if uiView.isHidden == true {
        attributes.append("$0.isHidden = true")
    }
    if uiView.clipsSubviews == true {
        attributes.append("$0.clipsToBounds = true")
    }
    if let contentMode = uiView.contentMode, contentMode != "left" {
        attributes.append("$0.contentMode = .\(contentMode)")
    }
    if uiView.userInteractionEnabled == true {
        attributes.append("$0.isUserInteractionEnabled == true")
    }
    if let alpha = uiView.alpha, alpha != 1 {
        attributes.append("$0.alpha = \(alpha)")
    }
    if let backgroundColor = uiView.backgroundColor {
        attributes.append("$0.backgroundColor = \(colorToCode(backgroundColor))")
    }
    if let tintColor = uiView.tintColor {
        attributes.append("$0.tintColor = \(colorToCode(tintColor))")
    }
    if uiView.opaque == .some(false) {
        attributes.append("$0.isOpaque = false")
    }
    if let horizontalHuggingPriority = uiView.horizontalHuggingPriority, horizontalHuggingPriority != 250 {
        attributes.append("$0.setContentHuggingPriority(\(resistancePriorityToCode(horizontalHuggingPriority)), for: .horizontal)")
    }
    if let verticalHuggingPriority = uiView.verticalHuggingPriority, verticalHuggingPriority != 250 {
        attributes.append("$0.setContentHuggingPriority(\(resistancePriorityToCode(verticalHuggingPriority)), for: .vertical)")
    }
    if let horizontalCompressionResistancePriority = uiView.horizontalCompressionResistancePriority, horizontalCompressionResistancePriority != 750 {
        attributes.append("$0.setContentCompressionResistancePriority(\(resistancePriorityToCode(horizontalCompressionResistancePriority)), for: .horizontal)")
    }
    if let verticalCompressionResistancePriority = uiView.verticalCompressionResistancePriority, verticalCompressionResistancePriority != 750 {
        attributes.append("$0.setContentCompressionResistancePriority(\(resistancePriorityToCode(verticalCompressionResistancePriority)), for: .vertical)")
    }
    return attributes
}

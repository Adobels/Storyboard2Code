//
//  parseUIView.swift
//  story2code
//
//  Created by Blazej Sleboda on 02/04/2025.
//

import StoryboardDecoder

func parseUIView(of view: ViewProtocol) -> [String] {
    var result: [String] = []
    if let value = view.contentMode  {
        result.append("$0.contentMode = .\(value)")
    }
    if let value = view.semanticContentAttribute {
        result.append("$0.semanticContentAttribute = .\(value)")
    }
    if let value = view.tag {
        result.append("$0.tag = \(value)")
    }
    if let value = view.userInteractionEnabled {
        result.append("$0.isUserInteractionEnabled = \(value)")
    }
    if let value = view.multipleTouchEnabled {
        result.append("$0.isMultipleTouchEnabled = \(value)")
    }
    if let value = view.alpha {
        result.append("$0.alpha = \(value)")
    }
    if let value = view.backgroundColor {
        result.append("$0.backgroundColor = \(colorToCode(value))")
    }
    if let value = view.tintColor {
        result.append("$0.tintColor = \(colorToCode(value))")
    }
    if let value = view.opaque {
        result.append("$0.isOpaque = \(value)")
    }
    if let value = view.hidden {
        result.append("$0.isHidden = \(value)")
    }
    if let value = view.clearsContextBeforeDrawing {
        result.append("$0.clearsContextBeforeDrawing = \(value)")
    }
    if let value = view.clipsSubviews {
        result.append("$0.clipsToBounds = \(value)")
    }
    if let value = view.autoresizesSubviews {
        result.append("$0.autoresizesSubviews = \(value)")
    }
    // Size Inspector properties
    if let horizontalHuggingPriority = view.horizontalHuggingPriority, horizontalHuggingPriority != 250 {
        result.append("$0.setContentHuggingPriority(\(resistancePriorityToCode(horizontalHuggingPriority)), for: .horizontal)")
    }
    if let verticalHuggingPriority = view.verticalHuggingPriority, verticalHuggingPriority != 250 {
        result.append("$0.setContentHuggingPriority(\(resistancePriorityToCode(verticalHuggingPriority)), for: .vertical)")
    }
    if let horizontalCompressionResistancePriority = view.horizontalCompressionResistancePriority, horizontalCompressionResistancePriority != 750 {
        result.append("$0.setContentCompressionResistancePriority(\(resistancePriorityToCode(horizontalCompressionResistancePriority)), for: .horizontal)")
    }
    if let verticalCompressionResistancePriority = view.verticalCompressionResistancePriority, verticalCompressionResistancePriority != 750 {
        result.append("$0.setContentCompressionResistancePriority(\(resistancePriorityToCode(verticalCompressionResistancePriority)), for: .vertical)")
    }
    return result
}

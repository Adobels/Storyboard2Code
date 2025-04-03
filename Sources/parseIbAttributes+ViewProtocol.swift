//
//  File.swift
//  story2code
//
//  Created by Blazej Sleboda on 02/04/2025.
//

import IBDecodable

@MainActor
func parseIbAttributes(of uiView: ViewProtocol) -> [String] {
    var attributes: [String] = []
    if uiView.isHidden == true {
        attributes.append("isHidden = true")
    }
    if uiView.clipsSubviews == true {
        attributes.append("clipsToBounds = true")
    }
    if let contentMode = uiView.contentMode, contentMode != "left" {
        attributes.append("contentMode = .\(contentMode)")
    }
    if uiView.userInteractionEnabled == true {
        attributes.append("isUserInteractionEnabled == true")
    }
    if let alpha = uiView.alpha, alpha != 1 {
        attributes.append("alpha = \(alpha)")
    }
    if let backgroundColor = uiView.backgroundColor {
        attributes.append("backgroundColor = \(backgroundColor)")
    }
    if let tintColor = uiView.tintColor {
        //TODO: Color
        _ = tintColor
    }
    if uiView.opaque == .some(false) {
        attributes.append("isOpaque = false")
    }
    if let verticalHuggingPriority = uiView.verticalHuggingPriority, verticalHuggingPriority != 250 {
        attributes.append("setContentHuggingPriority(\(verticalHuggingPriority), for: .vertical)")
    }
    if let horizontalHuggingPriority = uiView.horizontalHuggingPriority, horizontalHuggingPriority != 250 {
        attributes.append("setContentHuggingPriority(\(horizontalHuggingPriority), for: .horizontal)")
    }
    if let horizontalCompressionResistancePriority = uiView.horizontalCompressionResistancePriority, horizontalCompressionResistancePriority != 750 {
        attributes.append("setContentCompressionResistancePriority(\(horizontalCompressionResistancePriority), for: .horizontal)")
    }
    if let verticalCompressionResistancePriority = uiView.verticalCompressionResistancePriority, verticalCompressionResistancePriority != 750 {
        attributes.append("setContentCompressionResistancePriority(\(verticalCompressionResistancePriority), for: .vertical)")
    }

    if let userDefinedRuntimeAttributes = uiView.userDefinedRuntimeAttributes {
        userDefinedRuntimeAttributes.forEach {
            attributes.append("\($0.keyPath) \($0.type) \($0.value)")
        }
    }
    return attributes
}

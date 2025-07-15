//
//  File.swift
//  story2code
//
//  Created by Blazej Sleboda on 02/04/2025.
//

import StoryboardDecoder

func parseIbAttributes(of view: Label) -> [String] {
    var attributes: [String] = []
    // Client project uses user runtime attributes to set the title
//    if let text = view.text {
//        attributes.append("$0.text = \"\(text)\"")
//    }
    attributes.append(contentsOf: parseViewProtocol(of: view))
    if let attributedText = view.attributedText {
        attributes.append("$0.attributedText = \"\(attributedText)\"")
    }
    if let fontDescription = view.fontDescription {
        attributes.append("$0.font = \(fontDescriptionToCode(fontDescription))")
    }
    if let textColor = view.textColor {
        attributes.append("$0.textColor = \(colorToCode(textColor))")
    }
    if let textAlignment = view.textAlignment {
        attributes.append("$0.textAlignment = .\(textAlignment)")
    }
    // var lineBreakStrategy: NSParagraphStyle.LineBreakStrategy
    if let value = view.enabled {
        attributes.append("$0.isEnabled = \(value)")
    }
    // var enablesMarqueeWhenAncestorFocused: Bool
    // var showsExpansionTextWhenTruncated: Bool
    if let value = lineBreakModeToCode(view.lineBreakMode) {
        if value != "lineBreakMode" {
            attributes.append("$0.lineBreakMode = .\(value)")
        }
    }
    if let adjustsFontSizeToFit = view.adjustsFontSizeToFit {
        attributes.append("$0.adjustsFontSizeToFitWidth = \(adjustsFontSizeToFit)")
    }
    if let value = view.adjustsLetterSpacingToFitWidth, value {
        attributes.append("$0.allowsDefaultTighteningForTruncation = \(value)")
    }
    if let baselineAdjustment = view.baselineAdjustment {
        if baselineAdjustment != "byTruncatingTail" {
            attributes.append("$0.baselineAdjustment = .\(baselineAdjustment)")
        }
    }
    if let minimumScaleFactor = view.minimumScaleFactor {
        attributes.append("$0.minimumScaleFactor = \(minimumScaleFactor)")
    }
    if let value = view.minimumFontSize {
        attributes.append("$0.minimumFontSize = \(value)")
    }
    if let numberOfLines = view.numberOfLines {
        attributes.append("$0.numberOfLines = \(numberOfLines)")
    }
    if let value = view.shadowOffset {
        attributes.append("$0.shadowOffset = \(value)")
    }
    return attributes
}

//
//  File.swift
//  story2code
//
//  Created by Blazej Sleboda on 02/04/2025.
//

import StoryboardDecoder

func parseIbAttributes(of view: Label) -> [String] {
    var attributes: [String] = []
    if let text = view.text {
        attributes.append("$0.text = \"\(text)\"")
    }
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
    if let lineBreakMode = view.lineBreakMode {
        let codePropertyLineBreakMode: String = switch lineBreakMode {
        case "wordWrap": "byWordWrapping"
        case "characterWrap": "byCharWrapping"
        case "clip": "byClipping"
        case "headTruncation": "byTruncatingHead"
        case "tailTruncation": "byTruncatingTail"
        case "middleTruncation": "byTruncatingMiddle"
        default: fatalError()
        }
        attributes.append("$0.lineBreakMode = .\(codePropertyLineBreakMode)")
    }
    if let adjustsFontSizeToFit = view.adjustsFontSizeToFit {
        attributes.append("$0.adjustsFontSizeToFitWidth = \(adjustsFontSizeToFit)")
    }
    if let value = view.adjustsLetterSpacingToFitWidth {
        attributes.append("$0.allowsDefaultTighteningForTruncation = \(value)")
    }
    if let baselineAdjustment = view.baselineAdjustment {
        attributes.append("$0.baselineAdjustment = .\(baselineAdjustment)")
    }
    if let minimumScaleFactor = view.minimumScaleFactor {
        attributes.append("$0.minimumScaleFactor = \(minimumScaleFactor)")
    }
    if let numberOfLines = view.numberOfLines {
        attributes.append("$0.numberOfLines = \(numberOfLines)")
    }
    // var sizingRule: UILetterformAwareSizingRule
    // var highlightedTextColor: UIColor?
    // var isHighlighted: Bool
    // var preferredVibrancy: UILabelVibrancy
    // var shadowColor: UIColor?
    // var shadowOffset: CGSize
    // var preferredMaxLayoutWidth: CGFloat
    return attributes
}

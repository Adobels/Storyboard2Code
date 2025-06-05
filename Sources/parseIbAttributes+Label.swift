//
//  File.swift
//  story2code
//
//  Created by Blazej Sleboda on 02/04/2025.
//

import IBDecodable

@MainActor
func parseIbAttributes(of view: Label) -> [String] {
    var attributes: [String] = []
    if let text = view.text {
        attributes.append("text = \(text)")
    }
    if let attributedText = view.attributedText {
        attributes.append("attributedText = \"\(attributedText)\"")
    }
    if let fontDescription = view.fontDescription {
        attributes.append("font = \(fontDescription)")
    }
    if let textColor = view.textColor {
        attributes.append("textColor = \(textColor)")
    }
    if let textAlignment = view.textAlignment {
        attributes.append("textAlignment = .\(textAlignment)")
    }
    // var lineBreakStrategy: NSParagraphStyle.LineBreakStrategy
    if let isEnabled = view.isEnabled {
        attributes.append("isEnabled = \(isEnabled)")
    }
    // var enablesMarqueeWhenAncestorFocused: Bool
    // var showsExpansionTextWhenTruncated: Bool
    if let lineBreakMode = view.lineBreakMode {
        attributes.append("lineBreakMode = .\(lineBreakMode)")
    }
    if let adjustsFontSizeToFit = view.adjustsFontSizeToFit {
        attributes.append("adjustsFontSizeToFitWidth = \(adjustsFontSizeToFit)")
    }
    if let allowsDefaultTighteningForTruncation = view.allowsDefaultTighteningForTruncation {
        attributes.append("allowsDefaultTighteningForTruncation = \(allowsDefaultTighteningForTruncation)")
    }
    if let baselineAdjustment = view.baselineAdjustment {
        attributes.append("baselineAdjustment = \(baselineAdjustment)")
    }
    if let minimumScaleFactor = view.minimumScaleFactor {
        attributes.append("minimumScaleFactor = \(minimumScaleFactor)")
    }
    if let numberOfLines = view.numberOfLines {
        attributes.append("numberOfLines = \(numberOfLines)")
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

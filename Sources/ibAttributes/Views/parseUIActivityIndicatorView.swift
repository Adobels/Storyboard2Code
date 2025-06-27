//
//  parseUIActivityIndicatorView.swift
//  story2code
//
//  Created by Blazej Sleboda on 26/06/2025.
//

import StoryboardDecoder

func parseUIActivityIndicatorView(of element: ActivityIndicatorView) -> [String] {
    var attr: [String] = .init()
    if let style = element.style {
        attr.append("$0.style = .\(style)")
    }
    if let color = element.color {
        attr.append("$0.color = .\(colorToCode(color))")
    }
    if let isAnimating = element.isAnimating {
        attr.append("$0.isAnimating = \(isAnimating)")
    }
    if let hidesWhenStopped = element.hidesWhenStopped {
        attr.append("$0.hidesWhenStopped = \(hidesWhenStopped)")
    }
    return attr
}

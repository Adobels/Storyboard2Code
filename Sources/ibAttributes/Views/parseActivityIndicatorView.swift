//
//  parseActivityIndicatorView.swift
//  story2code
//
//  Created by Blazej Sleboda on 26/06/2025.
//

import StoryboardDecoder

func parseActivityIndicatorView(of element: ActivityIndicatorView) -> [String] {
    var attr: [String] = .init()
    attr.append(contentsOf: parseViewProtocol(of: element))
    if let style = element.style {
        attr.append("$0.style = .\(style)")
    }
    if let color = element.color {
        attr.append("$0.color = .\(colorToCode(color))")
    }
    if let value = element.animating {
        attr.append("$0.isAnimating = \(value)")
    }
    if let hidesWhenStopped = element.hidesWhenStopped {
        attr.append("$0.hidesWhenStopped = \(hidesWhenStopped)")
    }
    return attr
}

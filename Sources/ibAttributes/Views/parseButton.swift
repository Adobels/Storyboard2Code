//
//  parseButton.swift
//  story2code
//
//  Created by Blazej Sleboda on 11/07/2025.
//

import StoryboardDecoder

func parseButton(of view: Button) -> [String] {
    var result: [String] = []
    if let value = view.lineBreakMode {
        result.append("$0.lineBreakMode = \(value)")
    }
    if let value = view.showsTouchWhenHighlighted {
        result.append("$0.showsTouchWhenHighlighted = \(value)")
    }
    if let value = view.adjustsImageWhenHighlighted {
        result.append("$0.adjustsImageWhenHighlighted = \(value)")
    }
    return result
}

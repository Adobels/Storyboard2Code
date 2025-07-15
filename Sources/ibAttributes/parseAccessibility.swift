//
//  parseAccessibility.swift
//  story2code
//
//  Created by Blazej Sleboda on 15/07/2025.
//

import StoryboardDecoder

func parseAccessibility(of view: ViewProtocol) -> [String] {
    guard let accessibility = view.accessibility else { return [] }
    var result = [String]()
    if let value = accessibility.label {
        result.append("$0.accessibilityLabel = \(value)")
    }
    if let value = accessibility.identifier {
        result.append("$0.accessibilityIdentifier = \(value)")
    }
    return result
}

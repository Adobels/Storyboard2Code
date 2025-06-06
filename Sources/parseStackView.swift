//
//  File 2.swift
//  story2code
//
//  Created by Blazej Sleboda on 05/06/2025.
//

import StoryboardDecoder

func parseStackViewAttributes(_ stackView: StackView) -> [String] {
    var attributes: [String] = []
    attributes.append("axis == .\(stackView.axis)")
    if let alignment = stackView.alignment {
        attributes.append("alignment = .\(alignment)")
    }
    if let distribution = stackView.distribution {
        attributes.append("distribution = .\(distribution)")
    }
    if let spacing = stackView.spacing {
        attributes.append("spacing = \(spacing)")
    }
    if let baselineRelativeArrangement = stackView.baselineRelativeArrangement {
        attributes.append("isBaselineRelativeArrangement = \(baselineRelativeArrangement)")
    }
    return attributes
}

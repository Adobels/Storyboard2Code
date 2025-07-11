//
//  File 2.swift
//  story2code
//
//  Created by Blazej Sleboda on 05/06/2025.
//

import StoryboardDecoder

func parseStackViewAttributes(_ stackView: StackView) -> [String] {
    var attributes: [String] = []
    if let alignment = stackView.alignment {
        attributes.append("$0.alignment = .\(alignment)")
    }
    if let distribution = stackView.distribution {
        attributes.append("$0.distribution = .\(distribution)")
    }
    if let spacing = stackView.spacing {
        attributes.append("$0.spacing = \(spacing)")
    }
    if let value = stackView.spacingType {
        attributes.append("$0.spacingType = \(value)")
    }
    if let baselineRelativeArrangement = stackView.baselineRelativeArrangement {
        attributes.append("$0.isBaselineRelativeArrangement = \(baselineRelativeArrangement)")
    }
    return attributes
}

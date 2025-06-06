//
//  File 2.swift
//  story2code
//
//  Created by Blazej Sleboda on 05/06/2025.
//

import StoryboardDecoder

struct UIStackView {
    let stackView: StackView
    init(_ stackView: StackView) {
        self.stackView = stackView
    }
    var axis: String { stackView.axis }
    var alignment: String? { stackView.alignment }
    var distribution: String? { stackView.distribution }
    var isBaselineRelativeArrangement: Bool? { stackView.baselineRelativeArrangement }
    var spacing: Int? { stackView.spacing }
}

func parseStackViewAttributes(_ stackView: StackView) -> [String] {
    var attributes: [String] = []
    let stackView = UIStackView(stackView)
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
    if let isBaselineRelativeArrangement = stackView.isBaselineRelativeArrangement {
        attributes.append("isBaselineRelativeArrangement = \(isBaselineRelativeArrangement)")
    }
    return attributes
}

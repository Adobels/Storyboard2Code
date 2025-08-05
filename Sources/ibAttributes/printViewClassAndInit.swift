//
//  printViewClassAndInit.swift
//  story2code
//
//  Created by Blazej Sleboda on 11/06/2025.
//

import StoryboardDecoder

func printViewClassAndInit(_ view: ViewProtocol, ctx: Context) -> [String] {
    var strings: [String] = []
    if ctx.debugEnabled {
        strings.append(G.logLiteral + #function + " begin")
        defer { strings.append(G.logLiteral + #function + " end") }
    }
    let elementId = view.id
    strings.append(contentsOf: printViewDiagnostics(of: view, ctx: ctx))
    if let stackView = view as? StackView {
        var resultsStackView = [String]()
        if stackView.axis == "vertical" {
            resultsStackView.append("VerticalStack(")
        } else {
            resultsStackView.append("HorizontalStack(")
        }
        var arguments: [String] = []
        if let value = stackView.spacing {
            arguments.append("spacing: " + String(value))
        }
        if let value = stackView.alignment {
            arguments.append("alignment: ." + value)
        }
        if let value = stackView.distribution {
            arguments.append("distribution: ." + value)
        }
        resultsStackView.append(arguments.joined(separator: ", "))
        resultsStackView.append(")")
        strings.append(resultsStackView.joined())
    } else {
        let viewClass = view.customClass ?? view.elementClass
        strings.append(viewClass + "()")
    }
    return strings
}

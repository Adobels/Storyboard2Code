//
//  printViewClassAndInit.swift
//  story2code
//
//  Created by Blazej Sleboda on 11/06/2025.
//

import StoryboardDecoder

func printViewClassAndInit(_ element: ViewProtocol) -> [String] {
    let elementClass = element.customClass ?? element.elementClass
    let elementId = element.id
    var results: [String] = []
    if let stackView = element as? StackView {
        if stackView.axis == "vertical" {
            results.append("VerticalStack(")
        } else {
            results.append("HorizontalStack(")
        }
        var arguments: [String] = []
        if let value = stackView.spacing {
            arguments.append("spacing: " + String(value))
        }
        if let value = stackView.alignment {
            arguments.append("alignment: " + value)
        }
        if let value = stackView.distribution {
            arguments.append("distribution: " + value)
        }
        let joinedArguments = arguments.joined(separator: ",")
        results.append(joinedArguments)
        results.append(")")
    } else {
        results.append(elementClass + "()")
    }
    results.append(G.logLiteral)
    results.append("id: " + elementId)
    results.append("sid: " + sanitizedOutletName(from: elementId)!)
    if let value = element.userLabel { results.append("userLabel: " + value) }
    if let value = element.key { results.append("key: " + value) }
    return [results.joined(separator: " ")]
}

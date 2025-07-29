//
//  printViewClassAndInit.swift
//  story2code
//
//  Created by Blazej Sleboda on 11/06/2025.
//

import StoryboardDecoder

func printViewClassAndInit(_ view: ViewProtocol) -> [String] {
    var strings: [String] = []
    if Context.shared.debugEnabled {
       strings.append(G.logLiteral + #function + " begin")
    }
    let elementId = view.id
    _ = {
        var resultsLog: [String] = []
        resultsLog.append(G.logLiteral)
        resultsLog.append("id: " + elementId)
        resultsLog.append("sid: " + sanitizedOutletName(from: elementId)!)
        if let value = view.userLabel { resultsLog.append("userLabel: " + value) }
        if let value = view.key {resultsLog.append("key: " + value) }
        strings.append(resultsLog.joined(separator: ", "))
    }() as Void
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
    if Context.shared.debugEnabled {
       strings.append(G.logLiteral + #function + " end")
    }
    return strings
}

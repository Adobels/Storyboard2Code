//
//  printViewClassAndInit.swift
//  story2code
//
//  Created by Blazej Sleboda on 11/06/2025.
//

import StoryboardDecoder

func printViewClassAndInit(_ element: AnyView) -> [String] {
    let elementClass = element.view.customClass ?? element.view.elementClass
    let elementId = element.view.id
    var results: [String] = []
    results.append("\(elementClass)()")
    if let stackView = element.view as? StackView {
        let axis = stackView.axis ?? "horizontal"
        results = ["\(elementClass)(axis: .\(axis))"]
    }
    results.append(G.logLiteral)
    results.append(elementId)
    let index = Context.shared.rootView.children(of: AnyView.self, recursive: true).firstIndex(where: {
        $0.view.id == elementId
    })!
    results.append("viewName: \(index)")
    results.append("userLabel: \(element.view.userLabel)")
    results.append("key: \(element.view.key)")
    return [results.joined(separator: " ")]
}

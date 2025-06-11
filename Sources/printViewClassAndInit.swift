//
//  printViewClassAndInit.swift
//  story2code
//
//  Created by Blazej Sleboda on 11/06/2025.
//

import StoryboardDecoder

func printViewClassAndInit(_ element: AnyView) -> [String] {
    let elementClass = element.view.customClass ?? element.view.elementClass
    let elementId = sanitizedOutletName(from: (element.view as! IBIdentifiable).id)!
    var output: [String] = []
    output = ["\(elementClass)()"]
    if let stackView = element.view as? StackView, stackView.isVertical {
        output = ["\(elementClass)(axis: .vertical)"]
    }
    output.append("// ")
    output.append(elementId)
    output.append("userLabel: \(element.view.userLabel)")
    output.append("key: \(element.view.key)")
    return [output.joined(separator: " ")]
}

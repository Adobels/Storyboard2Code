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
    var output: [String] = []
    output = ["\(elementClass)()"]
    if let stackView = element.view as? StackView, let axis = stackView.axis {
        output = ["\(elementClass)(axis: .\(axis))"]
    }
    output.append(K.logLiteral)
    output.append(elementId)
    let index = Context.shared.rootView.children(of: AnyView.self, recursive: true).firstIndex(where: {
        ($0.view as! IBIdentifiable).id == (element.view as! IBIdentifiable).id
    })!
    output.append("viewName \(index)")
    output.append("userLabel: \(element.view.userLabel)")
    output.append("key: \(element.view.key)")
    return [output.joined(separator: " ")]
}

func shouldInvertConstraint(owner: ViewProtocol, firstElement: String?, secondElement: String?) -> Bool {
    guard firstElement != nil, let secondElement else { return false }
    var firstElement = firstElement ?? (owner as! IBIdentifiable).id
    let firstElementPostionInDocumentOutline = elementPositionInDocumentOutline(elementId: firstElement)
    let secondElementPostionInDocumentOutline = elementPositionInDocumentOutline(elementId: secondElement)
    return firstElementPostionInDocumentOutline > secondElementPostionInDocumentOutline
}

func elementPositionInDocumentOutline(elementId: String) -> Int {
    Context.shared.rootView.flattened.firstIndex(where: {
        let id = ($0 as? IBIdentifiable)?.id
        if let id {
            return id == elementId
        } else {
            return false
        }
    } ) ?? -1
}

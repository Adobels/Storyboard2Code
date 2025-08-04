//
//  File.swift
//  story2code
//
//  Created by Blazej Sleboda on 04/08/2025.
//

import StoryboardDecoder

func printSceneCustomView(_ customView: AnyView, ctx: ParsingOutput) {
    let customView = customView.nested
    ctx.output.append(contentsOf: printViewDiagnostics(of: customView))
    ctx.output.append("var \(customView.id) = " + printViewClassAndInit(customView).joined() + "()")
    Context.shared.visitedIBIdentifiables.append(customView.id)
    if let subviews = customView.subviews, subviews.hasContent {
        ctx.output.appendToLastElement(".ibSubviews {")
        printSubviews(elements: subviews.map { $0.view })
        ctx.output.append("}")
    }
    var properties = parseViewProtocol(of: customView)
    if properties.hasContent {
        ctx.output.appendToLastElement(".ibAttributes {")
        ctx.output.append(contentsOf: properties)
        ctx.output.append("}")
    }
}

//
//  printView.swift
//  story2code
//
//  Created by Blazej Sleboda on 11/06/2025.
//

import StoryboardDecoder

func printRootView(_ rootView: View, ctx: ParsingOutput) {
    ctx.output.append(printViewDiagnostics(of: rootView))
    ctx.output.append("view")
    Context.shared.visitedIBIdentifiables.append(rootView.id)
    if let subviews = rootView.subviews, !subviews.isEmpty {
        ctx.output.append(".ibSubviews {")
        printSubviews(elements: subviews.map { $0.view })
        ctx.output.append("}")
    }
    var properties = parseView(of: rootView)
    properties.removeAll(where: { $0 == #"$0.key = "view""# })
    properties.append("$0.backgroundColor = RootViewComponentTheme().background")
    Context.shared.gestures.forEach {
        properties.append(contentsOf: parseTapGestureRecognizer($0))
    }
    if !properties.isEmpty {
        ctx.output.append(".ibAttributes {")
        ctx.output.append(contentsOf: properties)
        ctx.output.append("}")
    }
}


func printSubviews(elements: [ViewProtocol]) {
    elements.forEach { element in
        Context.shared.output.append(contentsOf: printViewClassAndInit(element))
        _ = {
            if Context.shared.debugEnabled {
                Context.shared.output.append(G.logLiteral + #function + ":" + String(#line) + " begin")
                defer { Context.shared.output.append(G.logLiteral + #function + ":" + String(#line) + " end") }
            }
            Context.shared.output.append(".ibOutlet(&\(element.id))") // Each view have at this moment an outlet to its ID, compiler will help to eleminate the redundant outlets
            Context.shared.referencingOutletsMgr.viewControllerOutlets // These are view controller level outlets
                .filter { $0.destination == element.id }
                .forEach { Context.shared.output.append(".ibOutlet(&" + $0.property + ")") }
        }() as Void
        Context.shared.visitedIBIdentifiables.append(element.id)
        if let subviews = element.subviews?.map { $0.view }, !subviews.isEmpty {
            Context.shared.output.append(".ibSubviews {")
            printSubviews(elements: subviews)
            Context.shared.output.append("}")
        }
        printIbAttributes(of: element)
    }
}

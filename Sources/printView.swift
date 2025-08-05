//
//  printView.swift
//  story2code
//
//  Created by Blazej Sleboda on 11/06/2025.
//

import StoryboardDecoder

func printRootView(_ rootView: View, ctx: Context) {
    ctx.output.append(contentsOf: printViewDiagnostics(of: rootView, ctx: ctx))
    ctx.output.append("view")
    ctx.visitedIBIdentifiables.append(rootView.id)
    if let subviews = rootView.subviews, !subviews.isEmpty {
        //ctx.output.append(".ibSubviews {")
        ctx.output.appendToLastElement(".ibSubviews {")
        printSubviews(elements: subviews.map { $0.view }, ctx: ctx)
        ctx.output.append("}")
    }
    var properties = parseView(of: rootView)
    properties.removeAll(where: { $0 == #"$0.key = "view""# })
    properties.append("$0.backgroundColor = RootViewComponentTheme().background")
    if !properties.isEmpty {
        //ctx.output.append(".ibAttributes {")
        ctx.output.appendToLastElement(".ibAttributes {")
        ctx.output.append(contentsOf: properties)
        ctx.output.append("}")
    }
}

func printSubviews(elements: [ViewProtocol], ctx: Context) {
    elements.forEach { element in
        ctx.output.append(contentsOf: printViewClassAndInit(element, ctx: ctx))
        _ = {
            if ctx.debugEnabled {
                ctx.output.append(G.logLiteral + #function + ":" + String(#line) + " begin")
                defer { ctx.output.append(G.logLiteral + #function + ":" + String(#line) + " end") }
            }
            ctx.output.appendToLastElement(".ibOutlet(&\(element.id))")
            //ctx.output.append(".ibOutlet(&\(element.id))") // Each view have at this moment an outlet to its ID, compiler will help to eleminate the redundant outlets
            ctx.referencingOutletsMgr.viewControllerOutlets // These are view controller level outlets
                .filter { $0.destination == element.id }
                .forEach { ctx.output.appendToLastElement(".ibOutlet(&" + $0.property + ")") }
        }() as Void
        ctx.visitedIBIdentifiables.append(element.id)
        if let subviews = element.subviews?.map { $0.view }, !subviews.isEmpty {
            ctx.output.appendToLastElement(".ibSubviews {")
            //ctx.output.append(".ibSubviews {")
            printSubviews(elements: subviews, ctx: ctx)
            ctx.output.append("}")
        }
        printIbAttributes(of: element, ctx: ctx)
    }
}

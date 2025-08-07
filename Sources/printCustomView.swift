//
//  File.swift
//  story2code
//
//  Created by Blazej Sleboda on 04/08/2025.
//

import StoryboardDecoder

func printSceneCustomView(_ customView: ViewProtocol, ctx: Context) {
    ctx.output.append(contentsOf: printViewDiagnostics(of: customView, ctx: ctx))
    ctx.output.append(contentsOf: printViewClassAndInit(customView, ctx: ctx))
    _ = {
        if ctx.debugEnabled {
            ctx.output.append(G.logLiteral + #function + ":" + String(#line) + " begin")
            defer { ctx.output.append(G.logLiteral + #function + ":" + String(#line) + " end") }
        }
        ctx.referencingOutletsMgr.viewControllerOutlets // These are view controller level outlets
            .filter { $0.destination == customView.id }
            .forEach { ctx.output.appendToLastElement(".ibOutlet(&" + $0.property + ")") }
    }() as Void
    ctx.visitedIBIdentifiables.append(customView.id)
    if let subviews = customView.subviews, subviews.hasContent {
        ctx.output.appendToLastElement(".ibSubviews { view in")
        _ = {
            var outletsToEachView: [String] = []
            customView.browse(skipSelf: true) { element in
                guard let view = element as? ViewProtocol else { return true }
                let userLabel = view.id
                outletsToEachView.append("var \(userLabel): \(view.customClass ?? view.elementClass)!")
                return true
            }
            if !outletsToEachView.isEmpty {
                outletsToEachView.insert("// swiftlint:disable identifier_name", at: 0)
                outletsToEachView.append("// swiftlint:enable identifier_name")
            }
            ctx.output.append(contentsOf: outletsToEachView)
        }() as Void
        printSubviews(elements: subviews.map { $0.view }, ctx: ctx)
        ctx.output.append("}")
    }
    printIbAttributes(of: customView, ctx: ctx)
}

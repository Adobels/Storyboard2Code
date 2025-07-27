//
//  printView.swift
//  story2code
//
//  Created by Blazej Sleboda on 11/06/2025.
//

import StoryboardDecoder

func printRootView(_ rootView: View, ctx: ParsingOutput) -> [String] {
    var results = [String]()
    ctx.output.append("view \(printViewDiagnostics(of: rootView)))")
    if let subviews = rootView.subviews, !subviews.isEmpty {
        ctx.output.append(".ibSubviews {")
        printSubviews(elements: subviews.map { $0.view })
        ctx.output.append("}")
    }
    var properties = parseView(of: rootView)
    properties.removeAll(where: { $0 == #"$0.key = "view""# })
    properties.append("$0.backgroundColor = RootViewComponentTheme().background")
    if !properties.isEmpty {
        ctx.output.append(".ibAttributes {")
        ctx.output.append(contentsOf: properties)
        ctx.output.append("}")
    }
    return results
}


func printSubviews(elements: [ViewProtocol]) {
    elements.forEach { element in
        Context.shared.output.append(contentsOf: printViewClassAndInit(element))
        Context.shared.output.append(".ibOutlet(&" + element.id + ")")
        let elementClass = element.customClass ?? element.elementClass
        let elementId = element.id
        Context.shared.variableViewIbOutlet.append((viewId: elementId, viewClass: elementClass))
        _ = {
            var viewIsOutletedInViewController: Bool = false
            Context.shared.viewControllerIBOutlets.forEach { outlet in
                if outlet.viewId == elementId {
                    Context.shared.output.append(".ibOutlet(&\(outlet.property))")
                    viewIsOutletedInViewController = true
                }
            }
        }()
        if let subviews = element.subviews?.map { $0.view }, !subviews.isEmpty {
            Context.shared.output.append(".ibSubviews {")
            printSubviews(elements: subviews)
            Context.shared.output.append("}")
        }
        printIbAttributes(of: element)
    }
}

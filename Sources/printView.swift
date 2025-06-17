//
//  printView.swift
//  story2code
//
//  Created by Blazej Sleboda on 11/06/2025.
//

import StoryboardDecoder

@MainActor
func printView(elements: [AnyView]) {
    guard !elements.isEmpty else { return }
    Context.shared.output.append(".ibSubviews {")
    elements.forEach { element in
        let elementClass = element.view.customClass ?? element.view.elementClass
        let elementId = sanitizedOutletName(from: (element.view as! IBIdentifiable).id)!
        Context.shared.output.append(contentsOf: printViewClassAndInit(element))
        Context.shared.variableViewIbOutlet.append((viewId: elementId, viewClass: elementClass))
        _ = {
            var viewIsOutletedInViewController: Bool = false
            Context.shared.viewControllerIBOutlets.forEach { outlet in
                if outlet.viewId == elementId {
                    Context.shared.output.append(".ibOutlet(&\(outlet.property))")
                    viewIsOutletedInViewController = true
                }
            }
            if !viewIsOutletedInViewController, let viewIbOutlet = getIbOutletToVariable(of: element.view) {
                Context.shared.output.append(viewIbOutlet)
            }
        }()
        let subviews = element.view.subviews
        if let subviews, subviews.count > 0 {
            printView(elements: subviews)
        }
        printIbAttributes(of: element)
    }
    Context.shared.output.append("}")
}

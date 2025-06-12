//
//  printViewControllerRootView.swift
//  story2code
//
//  Created by Blazej Sleboda on 11/06/2025.
//

import StoryboardDecoder

@MainActor
func printViewControllerRootView(_ anyViewController: AnyViewController) {
    guard let vc = anyViewController.viewController as? ViewController else {
        Context.shared.output.append("wrong view controller")
        return
    }
    let rootView: View = vc.rootView as! View
    let elements = rootView.subviews!
    Context.shared.rootView = rootView
    Context.shared.rootViewProtocol = vc.rootView!
    Context.shared.ibOutlet = vc.allConnections.compactMap { $0.connection as? Outlet }
    Context.shared.ibAction = vc.allConnections.compactMap { $0.connection as? Action }
    Context.shared.rootViewControllerId = vc.id
    _ = {
        var destinations: Set<String> = []
        vc.allConnections.filter {
            $0.connection is Outlet || $0.connection is Action
        }.forEach { destinations.insert(sanitizedOutletName(from: $0.connection.destination)!) }
        let viewsWithConstaints = vc.flattened.filter {
            let constraints = $0.children(of: Constraint.self)
            return !constraints.isEmpty
        }
        var viewIds: Set<String> = []
        viewsWithConstaints.forEach { view in
            let constaints = view.children(of: Constraint.self, recursive: false)
            _ = { view, constaints in
                constaints.forEach { constaint in
                    if let firstItem = constaint.firstItem {
                        viewIds.insert(sanitizedOutletName(from: firstItem)!)
                    } else {
                        viewIds.insert(sanitizedOutletName(from: (view as! IBIdentifiable).id)!)
                    }
                    if let secondItem = constaint.secondItem {
                        viewIds.insert(sanitizedOutletName(from: secondItem)!)
                    } else {
                        viewIds.insert(sanitizedOutletName(from: (view as! IBIdentifiable).id)!)
                    }
                }
            }(view, constaints)
        }
        let allDestinations: Set<String> = destinations.union(viewIds)
        Context.shared.variableViewIbOutlet2 = allDestinations
    }()
    guard !elements.isEmpty else { return }
    Context.shared.output.append(".ibSubviews {")
    elements.forEach { element in
        let elementClass = element.view.customClass ?? element.view.elementClass
        let elementId = sanitizedOutletName(from: (element.view as! IBIdentifiable).id)!
        Context.shared.output.append(contentsOf: printViewClassAndInit(element))
        Context.shared.variableViewIbOutlet.append((viewId: elementId, viewClass: elementClass))
        if let viewIbOutlet = getIbOutletToVariable(of: element.view) {
            Context.shared.output.append(viewIbOutlet)
        }
        getIbOutlet(of: element.view)
        let subviews = element.view.subviews
        if let subviews, subviews.count > 0 {
            printView(elements: subviews)
        }
        printIbAttributes(of: element)
    }
    Context.shared.output.append("}")
    printIbAttributes(getIBConstraints(of: rootView).sorted())
    let ibOutletsToViews: [String] = Context.shared.variableViewIbOutlet2.reduce([String](), { partialResult, ibViewId in
        let variableIsNeeded = Context.shared.variableViewIbOutlet.first { (viewId: String, viewClass: String) in
            viewId == ibViewId
        }
        return if let variableIsNeeded {
            partialResult + ["var \(variableIsNeeded.viewId): \(variableIsNeeded.viewClass)!"]
        } else {
            partialResult
        }
    })
    Context.shared.output.insert(contentsOf: ibOutletsToViews, at: 0)
}

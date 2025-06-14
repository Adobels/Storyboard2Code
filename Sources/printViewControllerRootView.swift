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
        var anyViews: [ViewProtocol] = rootView.children(of: AnyView.self, recursive: true).map { $0.view }
        anyViews.insert(rootView, at: 0)
        Context.shared.arrayRootViewFlattened = anyViews.enumerated().map { item in
            ViewPropertiesForParsing(
                id: (item.element as! IBIdentifiable).id,
                customClass: item.element.customClass,
                elementClass: item.element.elementClass,
                verticalPositionIndex: item.offset
            )
        }
        let constraints: [(viewId: String, constraints: [Constraint])] = anyViews.map {
            let result = (viewId: ($0 as! IBIdentifiable).id, constraints: $0.children(of: Constraint.self, recursive: false))
            return result
        }
        var arrayLayoutGuideIdToParentViewId: [LayoutGuideIdToParentViewId] = []
        rootView.browse(skipSelf: false) { item in
            guard let anyView = item as? ViewProtocol else { return true }
            if let view = anyView as? View, let viewLayoutGuide = view.viewLayoutGuide {
                arrayLayoutGuideIdToParentViewId.append(
                    .init(layoutGuideId: viewLayoutGuide.id, layoutGuideKey: viewLayoutGuide.key, parentViewId: view.id)
                )
            }
            return true
        }
        Context.shared.arrayLayoutGuideIdToParentViewId = arrayLayoutGuideIdToParentViewId
        var s2cConstraints: [(viewId: String, constraint: String)] = []
        rootView.browse { element in
            guard let view = element as? ViewProtocol else { return true }
            guard let constraints = view.constraints else { return true }
            let s2cConstraintsLocal: [(viewId: String, constraint: String)] = constraints.map { item in
                var s2cConstraintNew = S2CConstraint(
                    firstItem: item.firstItem,
                    firstAttribute: item.firstAttribute!,
                    relation: item.relation,
                    secondItem: item.secondItem,
                    secondAttribute: item.secondAttribute,
                    multiplier: item.multiplier,
                    priority: item.priority,
                    constant: item.constant,
                    identifier: item.identifier,
                    id: item.id
                )
                return s2cConstraintNew.convertToCode(with: .init(constraintParentViewId: (view as! IBIdentifiable).id, arrayLayoutGuideIdToParentViewId: Context.shared.arrayLayoutGuideIdToParentViewId, arrayRootViewFlattened: Context.shared.arrayRootViewFlattened))
            }
            s2cConstraints.append(contentsOf: s2cConstraintsLocal)
            Context.shared.arrayConstrains = s2cConstraints
            return true
        }
        Context.shared.arrayConstrains = s2cConstraints
    }()
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
    //printIbAttributes(getIBConstraints(of: rootView).sorted())
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

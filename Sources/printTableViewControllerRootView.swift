//
//  printTableViewControllerRootView.swift
//  story2code
//
//  Created by Blazej Sleboda on 23/07/2025.
//

import StoryboardDecoder

@MainActor
func printTableViewControllerRootView(_ anyViewController: AnyViewController) {
    guard let vc = anyViewController.viewController as? TableViewController else { fatalError() }
    Context.shared.viewController = anyViewController
    let rootView: TableView = vc.rootView as! TableView
    let elements: [ViewProtocol] = rootView.subviews!.map { $0.view } + (rootView.prototypeCells?.map { $0.view } ?? [])
    Context.shared.rootView = rootView as! ViewProtocol
    Context.shared.rootViewProtocol = vc.rootView!
    //Context.shared.ibOutlet = vc.allConnections.compactMap { $0.connection as? Outlet }
    _ = {
        let viewFlattened = vc.flattened.enumerated()
        var outlets: [S2COutlet] = []
        rootView.browse { element in
            guard let anyView = element as? ViewProtocol else { return true }
            guard let outlet = (anyView.connections?.compactMap { (($0 as? AnyConnection)?.connection as? Outlet) }) else { return true }
            let viewId = (anyView as! IBIdentifiable).id
            let currentViewOffset = viewFlattened.first { item in (item.element as? IBIdentifiable)?.id == viewId }!.offset
            outlet.forEach { outlet in
                let viewDestination = viewFlattened.first { item in
                    (item.element as? IBIdentifiable)?.id == .some(outlet.destination)
                }!
                if currentViewOffset > viewDestination.offset  {
                    outlets.append(S2COutlet(viewId: viewId, property: outlet.property, destination: outlet.destination, isOutletToDestination: true))
                } else {
                    outlets.append(S2COutlet(viewId: outlet.destination, property: outlet.property, destination: viewId, isOutletToDestination: false))
                }
            }
            return true
        }
        Context.shared.ibOutlet = outlets
    }()
    Context.shared.rootViewControllerId = vc.id
    _ = {
        Context.shared.viewControllerIBOutlets = arrayViewIdToProperty(anyViewController: Context.shared.viewController)
    }()
    _ = {
        Context.shared.constraints = convertConstraintsToCode(rootView: rootView)
    }()
    _ = {
        var destinations: Set<String> = []
        vc.allConnections.filter {
            $0.connection is Outlet || $0.connection is Action
        }.forEach { destinations.insert($0.connection.destination) }
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
                        viewIds.insert(firstItem)
                    } else {
                        viewIds.insert((view as! IBIdentifiable).id)
                    }
                    if let secondItem = constaint.secondItem {
                        viewIds.insert(secondItem)
                    } else {
                        viewIds.insert((view as! IBIdentifiable).id)
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
        let elementClass = element.customClass ?? element.elementClass
        let elementId = element.id
        Context.shared.output.append(contentsOf: printViewClassAndInit(element))
        Context.shared.variableViewIbOutlet.append((viewId: elementId, viewClass: elementClass))
        if let viewIbOutlet = getIbOutletToVariable(of: element) {
            Context.shared.output.append(viewIbOutlet)
        }
        let subviews = element.subviews?.map { $0.view }
        if let subviews, subviews.count > 0 {
            printView(elements: subviews)
        }
        printIbAttributes(of: element)
    }
    Context.shared.output.append("}")
    //printIbAttributes(getIBConstraints(of: rootView).sorted())
    let ibOutletsToViews: [String] = Context.shared.variableViewIbOutlet2.sorted().reduce([String](), { partialResult, ibViewId in
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

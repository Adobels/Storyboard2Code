//
//  printTableViewControllerRootView.swift
//  story2code
//
//  Created by Blazej Sleboda on 23/07/2025.
//

import StoryboardDecoder


func printTableViewControllerRootView(_ anyViewController: AnyViewController) {
    guard let vc = anyViewController.viewController as? TableViewController else { fatalError() }
    Context.shared.viewController = anyViewController
    let rootView: TableView = vc.rootView as! TableView
    let elements: [ViewProtocol] = rootView.subviews!.map { $0.view } + (rootView.prototypeCells?.map { $0.view } ?? [])
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
    _ = {
        Context.shared.viewControllerIBOutlets = arrayViewIdToProperty(anyViewController: Context.shared.viewController)
    }()
    _ = {
        Context.shared.constraints = convertConstraintsToCode(rootView: rootView)
    }()
//    guard !elements.isEmpty else { return }
//    Context.shared.output.append(".ibSubviews {")
//    elements.forEach { element in
//        let elementClass = element.customClass ?? element.elementClass
//        let elementId = element.id
//        Context.shared.output.append(contentsOf: printViewClassAndInit(element))
//        Context.shared.variableViewIbOutlet.append((viewId: elementId, viewClass: elementClass))
//        if let viewIbOutlet = getIbOutletToVariable(of: element) {
//            Context.shared.output.append(viewIbOutlet)
//        }
//        let subviews = element.subviews?.map { $0.view }
//        if let subviews, subviews.count > 0 {
//            printSubviews(elements: subviews)
//        }
//        printIbAttributes(of: element)
//    }
//    Context.shared.output.append("}")
//    Context.shared.output.insert(contentsOf: ibOutletsToViews, at: 0)
}

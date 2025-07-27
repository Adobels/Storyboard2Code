//
//  printViewControllerRootView.swift
//  story2code
//
//  Created by Blazej Sleboda on 11/06/2025.
//

import StoryboardDecoder

struct S2CView {
    let id: String
    let elementClass: String
    let customClass: String?
}
struct S2COutlet {
    let viewId: String
    let property: String
    let destination: String
    let isOutletToDestination: Bool
}

@MainActor
func printViewControllerRootView(_ anyViewController: AnyViewController) {
    guard let vc = anyViewController.viewController as? ViewController else { fatalError() }
    Context.shared.viewController = anyViewController
    let rootView: View = vc.rootView as! View
    let elements: [ViewProtocol] = rootView.subviews!.map { $0.view }
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
    printRootView(rootView, ctx: Context.shared)
    // OutletsForConstraints
    var outletsToEachView: [String] = []
    rootView.browse { element in
        guard let view = element as? ViewProtocol else { return true }
        outletsToEachView.append("var \(view.id): \(view.customClass ?? view.elementClass)!")
        return true
    }

//    let ibOutletsToViews: [String] = Context.shared.variableViewIbOutlet2.sorted().reduce([String](), { partialResult, ibViewId in
//        let variableIsNeeded = Context.shared.variableViewIbOutlet.first { (viewId: String, viewClass: String) in
//            viewId == ibViewId
//        }
//        return if let variableIsNeeded {
//            partialResult + ["var \(variableIsNeeded.viewId): \(variableIsNeeded.viewClass)!"]
//        } else {
//            partialResult
//        }
//    })
    if !outletsToEachView.isEmpty {
        outletsToEachView.insert("// swiftlint:disable identifier_name", at: 0)
        outletsToEachView.append("// swiftlint:enable identifier_name")
    }
    Context.shared.output.insert(contentsOf: outletsToEachView, at: 0)
}

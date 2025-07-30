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

struct S2COutlet: Equatable {
    let ownerId: String
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
    printRootView(rootView, ctx: Context.shared)
    // OutletsForConstraints
    var outletsToEachView: [String] = []
    rootView.browse { element in
        guard let view = element as? ViewProtocol else { return true }
        let userLabel = view.id
        outletsToEachView.append("var \(userLabel): \(view.customClass ?? view.elementClass)!")
        return true
    }
    outletsToEachView.remove(at: 0)
    if !outletsToEachView.isEmpty {
        outletsToEachView.insert("// swiftlint:disable identifier_name", at: 0)
        outletsToEachView.append("// swiftlint:enable identifier_name")
    }
    Context.shared.output.insert(contentsOf: outletsToEachView, at: 0)
}

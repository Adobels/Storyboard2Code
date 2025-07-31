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
    var results = [String]()
    results.append("class \(vc.customClass ?? "CustomClassIsMissing"): UIViewController {")
    results.append("required init?(coder: NSCoder) { super.init(coder: coder) }")
    results.append("override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {")
    results.append("super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)")
    if let value = vc.modalPresentationStyle {
        results.append("modalPresentationStyle = \(value)")
    }
    if let value = vc.storyboardIdentifier {
        results.append("storyboardIdentifier = \(value)")
    }
    // No need of sceneMemberID in code
    if let value = vc.tabBarItem {
        results.append("tabBarItem = \(value)")
    }
    if let value = vc.automaticallyAdjustsScrollViewInsets {
        results.append("automaticallyAdjustsScrollViewInsets = \(value)")
    }
    if let value = vc.hidesBottomBarWhenPushed {
        results.append("hidesBottomBarWhenPushed = \(value)")
    }
    // No need of autoresizesArchivedViewToFullSize in code
    // No need of wantsFullScreenLayout
    if let value = vc.extendedLayoutIncludesOpaqueBars {
        results.append("extendedLayoutIncludesOpaqueBars = \(value)")
    }
    results.append("}")
    results.append("override func loadView() {")
    results.append("super.loadView()")
    Context.shared.output.append(contentsOf: results)
    Context.shared.visitedIBIdentifiables.append(vc.id)
    let rootView: View = vc.rootView as! View
    // OutletsForConstraints
    var outletsToEachView: [String] = []
    rootView.browse(skipSelf: true) { element in
        guard let view = element as? ViewProtocol else { return true }
        let userLabel = view.id
        outletsToEachView.append("var \(userLabel): \(view.customClass ?? view.elementClass)!")
        return true
    }
    if !outletsToEachView.isEmpty {
        outletsToEachView.insert("// swiftlint:disable identifier_name", at: 0)
        outletsToEachView.append("// swiftlint:enable identifier_name")
    }
    Context.shared.output.append(contentsOf: outletsToEachView)
    printRootView(rootView, ctx: Context.shared)
    Context.shared.output.append("} \(G.logLiteral) loadView end ") // closing brace of loadView method
    Context.shared.output.append("} \(G.logLiteral) class end") // closing brace of class
}

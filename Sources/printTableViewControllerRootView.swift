//
//  printTableViewControllerRootView.swift
//  story2code
//
//  Created by Blazej Sleboda on 23/07/2025.
//

import StoryboardDecoder


func printTableViewControllerRootView(_ anyViewController: AnyViewController) {
    guard let vc = anyViewController.viewController as? TableViewController else { fatalError() }
    let rootView: TableView = vc.rootView as! TableView
    let elements: [ViewProtocol] = rootView.subviews!.map { $0.view } + (rootView.prototypeCells?.map { $0.view } ?? [])
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

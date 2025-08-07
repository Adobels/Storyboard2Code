//
//  printTableViewControllerRootView.swift
//  story2code
//
//  Created by Blazej Sleboda on 23/07/2025.
//

import StoryboardDecoder


func printTableViewControllerRootView(_ anyViewController: AnyViewController, ctx: Context) {
    guard let vc = anyViewController.viewController as? TableViewController else { fatalError() }
    var results = [String]()
    results.append("required init?(coder: NSCoder) { fatalError() }")
    results.append("override init(style: UITableView.Style) {")
    results.append("super.init(style: style)")
    results.append(contentsOf: parseTableViewController(vc))
    results.append("}")
    results.append("override func loadView() {")
    results.append("super.loadView()")
    ctx.output.append(contentsOf: results)
    ctx.visitedIBIdentifiables.append(vc.id)
    let rootView: TableView = vc.rootView as! TableView
    let elements: [ViewProtocol] = rootView.subviews!.map { $0.view } + (rootView.prototypeCells?.map { $0.view } ?? [])
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
    ctx.output.append(contentsOf: outletsToEachView)
    printRootView(rootView, ctx: ctx)
    ctx.output.append("} \(G.logLiteral) loadView end ") // closing brace of loadView method
}

func printRootView(_ rootView: TableView, ctx: Context) {
    ctx.output.append(contentsOf: printViewDiagnostics(of: rootView, ctx: ctx))
    ctx.output.append("tableView")
    ctx.visitedIBIdentifiables.append(rootView.id)
    if let subviews = rootView.sections?.compactMap { $0.cells }, !subviews.isEmpty {
        //ctx.output.append(".ibSubviews {")
        ctx.output.appendToLastElement(".ibSubviews {")
        printSubviews(elements: subviews.flatMap { $0 }.map { $0.nested }, ctx: ctx)
        ctx.output.append("}")
    }
    var properties = parseTableView(rootView)
    properties.removeAll(where: { $0 == #"$0.key = "view""# })
    properties.append("$0.backgroundColor = RootViewComponentTheme().background")
    if !properties.isEmpty {
        //ctx.output.append(".ibAttributes {")
        ctx.output.appendToLastElement(".ibAttributes {")
        ctx.output.append(contentsOf: properties)
        ctx.output.append("}")
    }
}

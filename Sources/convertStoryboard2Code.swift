//
//  convertStoryboard2Code.swift
//  story2code
//
//  Created by Blazej Sleboda on 26/07/2025.
//

import StoryboardDecoder

@discardableResult
@MainActor
public func convertStoryboard2Code(scene: Scene, ctx: Context) -> [String] {
    guard let anyViewController = scene.viewController else { fatalError() }
    ctx.output.append(
        "class \(anyViewController.nested.customClass ?? "CustomClassIsMissing"): UIViewController {"
    )
    if let viewController = anyViewController.viewController as? ViewController {
        printViewControllerRootView(anyViewController, ctx: ctx)
    }
    if let vc = anyViewController.viewController as? TableViewController {
        printTableViewControllerRootView(anyViewController, ctx: ctx)
        ctx.output.append(contentsOf: parseTableViewController(vc))
    }
    ctx.output.append("func viewDidLoad() {")
    ctx.output.append("super.viewDidLoad()")
    scene.customViews?.map { $0.nested }.forEach { customView in
        ctx.rootViewId = customView.id
        ctx.constraints = convertConstraintsToCode(rootView: customView, ctx: ctx)
        printSceneCustomView(customView, ctx: ctx)
    }
    ctx.output.append("} \(G.logLiteral) viewDidLoad end")
    ctx.output.append("} \(G.logLiteral) class end")
    return ctx.output
}

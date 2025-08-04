//
//  convertStoryboard2Code.swift
//  story2code
//
//  Created by Blazej Sleboda on 26/07/2025.
//

import StoryboardDecoder

@discardableResult
@MainActor
public func convertStoryboard2Code(scene: Scene) -> [String] {
    guard let anyViewController = scene.viewController else { fatalError() }
    Context.shared.output.append(
        "class \(anyViewController.nested.customClass ?? "CustomClassIsMissing"): UIViewController {"
    )
    if let viewController = anyViewController.viewController as? ViewController {
        printViewControllerRootView(anyViewController)
    }
    if let vc = anyViewController.viewController as? TableViewController {
        printTableViewControllerRootView(anyViewController)
        Context.shared.output.append(contentsOf: parseTableViewController(vc))
    }
    scene.customViews?.forEach { customView in
        Context.shared.output.append("")
        printSceneCustomView(customView, ctx: Context.shared)
    }
    Context.shared.output.append("} \(G.logLiteral) class end")
    return Context.shared.output
}

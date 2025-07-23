//
//  main.swift
//  story2code
//
//  Created by Blazej Sleboda on 20/03/2025.
//

import Foundation
import StoryboardDecoder

let url = Bundle.module.url(forResource: "ToParse", withExtension: "xml")!
let sb = try! StoryboardFile(url: url)
let initialScene = sb.document.scenes!.first!
Context.shared.actions = extractActions(of: initialScene)
let result = convertStoryboard2Code(initialScene.viewController!)
if !Context.shared.actions.isEmpty {
    print("Unused Actions Detected")
    Context.shared.actions.forEach {
        print("\($0.actionId), \($0.ownerId), \($0.code)")
    }
}

@MainActor
@discardableResult
public func convertStoryboard2Code(_ anyViewController: AnyViewController) -> [String] {
    printViewControllerRootView(anyViewController)
    if let viewController = anyViewController.viewController as? ViewController {
        Context.shared.output.append(contentsOf: parseViewController(viewController))
        if initialScene.customObjects?.isEmpty == .some(false) {
            Context.shared.output.append("view controller has additional views to parse")
        }
    }
    print(Context.shared.output.joined(separator: "\n"))
    return Context.shared.output
}

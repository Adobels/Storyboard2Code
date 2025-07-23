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
convertStoryboard2Code(initialScene.viewController!)
sanitizeIds()
print(Context.shared.output.joined(separator: "\n"))
initialScene.gestureRecognizers?.forEach { gesture in
    print("Has gesture: ")
    print(gesture.gestureRecognizer.id)
}
initialScene.customViews?.forEach {
    print("Has custom Views \($0.view.id)")
}
initialScene.customObjects?.forEach {
    print("Has custom Objects \($0.id)")
}
if sb.document.scenes!.count > 1 {
    print("Has more than one scene")
}
if !Context.shared.actions.isEmpty {
    print("Unused Actions Detected")
    Context.shared.actions.forEach {
        print("\($0.actionId), \($0.ownerId), \($0.code)")
    }
}
if !Context.shared.constraints.isEmpty {
    print("Unused Constraints Detected")
    Context.shared.constraints.forEach {
        print("\($0.constraintId), \($0.viewId), \($0.code)")
    }
}

@MainActor
@discardableResult
public func convertStoryboard2Code(_ anyViewController: AnyViewController) -> [String] {
    if let viewController = anyViewController.viewController as? ViewController {
        printViewControllerRootView(anyViewController)
        Context.shared.output.append(contentsOf: parseViewController(viewController))
    }
    if let vc = anyViewController.viewController as? TableViewController {
        printTableViewControllerRootView(anyViewController)
        Context.shared.output.append(contentsOf: parseTableViewController(vc))
    }
    return Context.shared.output
}

@MainActor
func generateListOfIBIdentifiable() -> [String] {
    var strings = [String]()
    sb.document.browse { element in
        guard let ibIdentifiable = element as? IBIdentifiable else { return true }
        strings.append(ibIdentifiable.id)
        return true
    }
    return strings
}

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
let viewController: ViewControllerProtocol = initialScene.viewController!.viewController
let rootView: ViewProtocol = viewController.rootView!

Context.shared.debugEnabled = false
Context.shared.viewControllerId = initialScene.viewController!.viewController.id
Context.shared.rootViewId = initialScene.viewController!.viewController.rootView!.id
Context.shared.referencingOutletsMgr = .init(scene: initialScene)
Context.shared.actions = extractActions(of: initialScene)
Context.shared.gestures = extractGestures(of: initialScene)
Context.shared.constraints = convertConstraintsToCode(rootView: rootView)

convertStoryboard2Code(initialScene.viewController!)

@MainActor
func replaceIdsWithUserLabels() {
    var userLabels: [(elementId: String, userLabel: String)] = []
    rootView.browse { element in
        guard let view = element as? ViewProtocol else { return true }
        if let userLabel = view.userLabel {
            userLabels.append((view.id, userLabel))
        }
        return true
    }
    userLabels.append((viewController.id, "self"))
    userLabels.append((rootView.id, "view"))
    userLabels.forEach { userLabel in
        let result = Context.shared.output.map { $0.replacingOccurrences(of: userLabel.elementId, with: userLabel.userLabel)}
        Context.shared.output = result
    }
}
replaceIdsWithUserLabels()
sanitizeIds()
replaceColorToClientTheme()
func replaceColorToClientTheme() {
    Context.shared.output = Context.shared.output.map {
        var result = ""
        result = $0.replacingOccurrences(of: ".init(cgColor: .init(genericGrayGamma2_2Gray: 0.0, alpha: 1.0))", with: "Colors.black")
        result = result.replacingOccurrences(of: ".init(cgColor: .init(genericGrayGamma2_2Gray: 1.0, alpha: 1.0))", with: "Colors.white")
        result = result.replacingOccurrences(of: ".init(cgColor: .init(genericGrayGamma2_2Gray: 0.0, alpha: 0.0))", with: ".clear")
        return result
    }
}
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

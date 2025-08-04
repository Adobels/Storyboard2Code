//
//  main.swift
//  story2code
//
//  Created by Blazej Sleboda on 20/03/2025.
//

import Foundation
import StoryboardDecoder

@MainActor
func parseScene(_ scene: Scene) -> [String] {

    let viewController: ViewControllerProtocol = initialScene.viewController!.viewController
    let rootView: ViewProtocol = viewController.rootView!

    Context.shared.debugEnabled = false
    Context.shared.viewControllerId = initialScene.viewController!.viewController.id
    Context.shared.rootViewId = initialScene.viewController!.viewController.rootView!.id
    Context.shared.referencingOutletsMgr = .init(scene: initialScene)
    Context.shared.referencingOutletsMgr.viewControllerOutlets = viewController.connections?.compactMap { $0.connection as? Outlet } ?? []
    Context.shared.actions = extractActions(of: initialScene)
    Context.shared.gestures = extractGestures(of: initialScene)
    Context.shared.constraints = convertConstraintsToCode(rootView: rootView)

    convertStoryboard2Code(scene: initialScene)

    replaceIdsWithUserLabels(rootView: rootView, viewControllerId: viewController.id)
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
    initialScene.gestureRecognizers?.forEach { gesture in
        Context.shared.output.append("Has gesture: ")
        Context.shared.output.append(gesture.gestureRecognizer.id)
    }
    initialScene.customViews?.forEach {
        Context.shared.output.append("Has custom Views \($0.view.id)")
    }
    initialScene.customObjects?.forEach {
        Context.shared.output.append("Has custom Objects \($0.id)")
    }
    if sb.document.scenes!.count > 1 {
        Context.shared.output.append("Has more than one scene")
    }
    if !Context.shared.actions.isEmpty {
        Context.shared.output.append("Unused Actions Detected")
        Context.shared.actions.forEach {
            Context.shared.output.append("\($0.actionId), \($0.ownerId), \($0.code)")
        }
    }
    if !Context.shared.constraints.isEmpty {
        Context.shared.output.append("Unused Constraints Detected")
        Context.shared.constraints.forEach {
            Context.shared.output.append("\($0.constraintId), \($0.viewId), \($0.code)")
        }
    }
    return Context.shared.output
}

let url = Bundle.module.url(forResource: "ToParse", withExtension: "xml")!
let sb = try! StoryboardFile(url: url)
let initialScene = sb.document.scenes!.first!
parseScene(initialScene).forEach { print($0) }

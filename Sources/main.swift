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

    let ctx = try! Context.init(scene: scene)
    let viewController: ViewControllerProtocol = scene.viewController!.viewController
    let rootView: ViewProtocol = viewController.rootView!
    ctx.debugEnabled = false

    convertStoryboard2Code(scene: scene, ctx: ctx)

    replaceIdsWithUserLabels(rootView: rootView, viewControllerId: viewController.id, ctx: ctx)
    sanitizeIds(scene, ctx: ctx)
    replaceColorToClientTheme()
    func replaceColorToClientTheme() {
        ctx.output = ctx.output.map {
            var result = ""
            result = $0.replacingOccurrences(of: ".init(cgColor: .init(genericGrayGamma2_2Gray: 0.0, alpha: 1.0))", with: "Colors.black")
            result = result.replacingOccurrences(of: ".init(cgColor: .init(genericGrayGamma2_2Gray: 1.0, alpha: 1.0))", with: "Colors.white")
            result = result.replacingOccurrences(of: ".init(cgColor: .init(genericGrayGamma2_2Gray: 0.0, alpha: 0.0))", with: ".clear")
            return result
        }
    }
    scene.gestureRecognizers?.forEach { gesture in
        ctx.output.append("Has gesture: ")
        ctx.output.append(gesture.gestureRecognizer.id)
    }
    scene.customViews?.forEach {
        ctx.output.append("Has custom Views \($0.view.id)")
    }
    scene.customObjects?.forEach {
        ctx.output.append("Has custom Objects \($0.id)")
    }
//    if sb.document.scenes!.count > 1 {
//        ctx.output.append("Has more than one scene")
//    }
    if !ctx.actions.isEmpty {
        ctx.output.append("Unused Actions Detected")
        ctx.actions.forEach {
            ctx.output.append("\($0.actionId), \($0.ownerId), \($0.code)")
        }
    }
    if !ctx.constraints.isEmpty {
        ctx.output.append("Unused Constraints Detected")
        ctx.constraints.forEach {
            ctx.output.append("\($0.constraintId), \($0.viewId), \($0.code)")
        }
    }
    return ctx.output
}

print("START")
let url = Bundle.module.url(forResource: "ToParse", withExtension: "xml")!
let sb = try! StoryboardFile(url: url)
parseScene(sb.document.scenes!.first!).forEach { print($0) }

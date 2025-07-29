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
Context.shared.debugEnabled = false
Context.shared.actions = extractActions(of: initialScene)
_ = {
    var allConstraints = initialScene.children(of: Constraint.self)
    var outlets: [Outlet] = []
    _ = initialScene.browse { element in
        guard let connectionsOwner = element as? IBConnectionOwner else { return true }
        let currentOutlets = connectionsOwner.connections?.compactMap { $0.connection as? Outlet } ?? []
        outlets.append(contentsOf: currentOutlets)
        return true
    }
    outlets = outlets.filter { outlet in
        allConstraints.contains(where: { $0.id == outlet.destination })
    }
    Context.shared.constraintsOutlets = outlets
}() as Void

convertStoryboard2Code(initialScene.viewController!)
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

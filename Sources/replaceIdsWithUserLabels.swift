//
//  replaceIdsWithUserLabels.swift
//  story2code
//
//  Created by Blazej Sleboda on 04/08/2025.
//

import StoryboardDecoder

@MainActor
func replaceIdsWithUserLabels(scene: Scene, ctx: Context) {
    guard let viewController = scene.viewController?.viewController,
          let rootView = viewController.rootView else { return }

    let base: [(elementId: String, userLabel: String)] = [
        (viewController.id, "self"),
        (rootView.id, "view")
    ]

    let userLabels = ([rootView] + (scene.customViews ?? []) + ((scene.customObjects ?? []) as [IBIdentifiable]))
        .reduce(into: base) { acc, container in
            container.browse { element in
                guard let view = element as? ViewProtocol, let label = view.userLabel else { return true }
                acc.append((view.id, label))
                return true
            }
        }

    replaceIdsWithUserLabel(userLabels, ctx)
}

fileprivate func replaceIdsWithUserLabel(_ userLabels: [(elementId: String, userLabel: String)], _ ctx: Context) {
    userLabels.forEach { userLabel in
        let result = ctx.output.map { $0.replacingOccurrences(of: userLabel.elementId, with: userLabel.userLabel)}
        ctx.output = result
    }
}

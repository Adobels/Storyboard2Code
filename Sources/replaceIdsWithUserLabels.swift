//
//  replaceIdsWithUserLabels.swift
//  story2code
//
//  Created by Blazej Sleboda on 04/08/2025.
//

import StoryboardDecoder

@MainActor
func replaceIdsWithUserLabels(rootView: ViewProtocol, viewControllerId: String) {
    var userLabels: [(elementId: String, userLabel: String)] = []
    rootView.browse { element in
        guard let view = element as? ViewProtocol else { return true }
        if let userLabel = view.userLabel {
            userLabels.append((view.id, userLabel))
        }
        return true
    }
    userLabels.append((viewControllerId, "self"))
    userLabels.append((rootView.id, "view"))
    userLabels.forEach { userLabel in
        let result = Context.shared.output.map { $0.replacingOccurrences(of: userLabel.elementId, with: userLabel.userLabel)}
        Context.shared.output = result
    }
}

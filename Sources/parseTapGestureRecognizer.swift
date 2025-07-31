//
//  parseTapGestureRecognizer.swift
//  story2code
//
//  Created by Blazej Sleboda on 30/07/2025.
//

import StoryboardDecoder

func parseTapGestureRecognizer(_ gesture: AnyGestureRecognizer) -> [String] {
    guard let tapGesture: TapGestureRecognizer = gesture.gestureRecognizer as? TapGestureRecognizer else { return [] }
    var results = [String]()
    results.append("$0.addGestureRecognizer(")
    let actions: [Action] = tapGesture.connections?.compactMap { $0.connection as? Action } ?? []
    if actions.count == 1 {
        let action = actions.first!
        results.append("UITapGestureRecognizer(target: \(action.destination), action: #selector(\(transformMethodName(action.selector))))")
    } else {
        actions.forEach { action in
            results.append("UITapGestureRecognizer(target: \(action.destination), action: #selector(\(transformMethodName(action.selector))))")
        }
        results.append("Warning: many actions")
    }
    results.append(")")
    actions.forEach { action in
        Context.shared.actions.removeAll { extractedAction in
            extractedAction.actionId == action.id
        }
    }
    return results
}

//
//  File.swift
//  story2code
//
//  Created by Blazej Sleboda on 22/07/2025.
//

import StoryboardDecoder
import Foundation
struct ExtractedAction: Equatable {
    let actionId: String
    let ownerId: String
    let code: String
}

func extractActions(of scene: Scene) -> [ExtractedAction] {
    let destinations = extractDestinationsForActions(of: scene)
    var extractedActions = [ExtractedAction]()
    _ = scene.browse { element in
        guard let element = element as? AnyView else { return true }
        let actions = element.view.connections?.compactMap { $0.connection as? Action } ?? []
        actions.forEach { action in
            let expractedAction = ExtractedAction(
                actionId: action.id,
                ownerId: element.nested.id,
                code: convertActionToCode(action, destinations: destinations)
            )
            extractedActions.append(expractedAction)
        }
        return true
    }
    _ = scene.browse { element in
        guard let element = element as? AnyGestureRecognizer else { return true }
        let actions = element.nested.allConnections.compactMap { $0.connection as? Action }
        actions.forEach { action in
            let expractedAction = ExtractedAction(
                actionId: action.id,
                ownerId: element.nested.id,
                code: convertActionToCode(action, destinations: destinations)
            )
            extractedActions.append(expractedAction)
        }
        return true
    }
    return extractedActions
}


func extractDestinationsForActions(of scene: Scene) -> [CtxForActions.Destination] {
    let outlets = scene.children(of: Outlet.self)
    func getOutletPropertyNameFor(destination: String) -> String? {
        let outlet = outlets.first(where: { $0.destination == destination })
        return if let outlet {
            outlet.property
        } else {
            nil
        }
    }
    var destinations = [CtxForActions.Destination]()
    _ = scene.browse { element in
        if let element = element as? AnyViewController {
            destinations.append(.init(destinationId: element.nested.id, destinationName: "self"))
        } else if let element = element as? Placeholder, element.placeholderIdentifier == "IBFirstResponder" {
            destinations.append(.init(destinationId: element.id, destinationName: "firstResponder"))
        } else if let element = element as? AnyView {
            destinations.append(
                .init(
                    destinationId: element.nested.id,
                    destinationName: [element.nested.id, getOutletPropertyNameFor(destination: element.nested.id)].compactMap { $0 }.joined(separator: ".")
                )
            )
        }
        return true
    }
    return destinations
}

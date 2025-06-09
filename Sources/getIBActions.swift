//
//  getIBActions.swift
//  story2code
//
//  Created by Blazej Sleboda on 09/06/2025.
//

import StoryboardDecoder

func getIBActions(of element: ViewProtocol) -> [String] {
    guard let connections = element.connections else { return [] }
    let actions = (connections.compactMap { $0.connection as? Action })
    var actionsToReturn: [String] = []
    actions.forEach { action in
        let destination = isRootViewControllerId(action.destination) ? "self" : sanitizedOutletName(from: action.destination)!
        actionsToReturn.append("addTarget(\(destination)" + ", action: #selector(\(action.selector)), for: .\(action.eventType!))")
    }
    return actionsToReturn
}

func isRootViewControllerId(_ id: String) -> Bool {
    id == Context.shared.rootViewControllerId
}

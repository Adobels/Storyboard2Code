//
//  getIBActions.swift
//  story2code
//
//  Created by Blazej Sleboda on 09/06/2025.
//
import Foundation
import StoryboardDecoder

func getIBActions(of element: ViewProtocol) -> [String] {
    guard let connections = element.connections else { return [] }
    let actions = (connections.compactMap { $0.connection as? Action })
    var actionsToReturn: [String] = []
    actions.forEach { action in
        let destination = isRootViewControllerId(action.destination) ? "self" : sanitizedOutletName(from: action.destination)!
        actionsToReturn.append("$0.addTarget(\(destination)" + ", action: #selector(\(transformMethodName(action.selector))), for: .\(action.eventType!))")
    }
    return actionsToReturn
}

public func transformMethodName(_ input: String) -> String {
    var input = input
    let inputWithoutEvent = input.replacingOccurrences(of: "forEvents:", with: "")
    let hasEvent = inputWithoutEvent.count != input.count
    let with = "With"
    let result: String
    if inputWithoutEvent.contains(with) {
        var components = inputWithoutEvent.components(separatedBy: with)
        result = "\(components.first!)(\(components.last!.lowercased())"
    } else {
        result = inputWithoutEvent.replacingOccurrences(of: ":", with: "(_:")
    }
    return result + (hasEvent ? "forEvents:" : "") + (result.contains("(") ? ")" : "")
}

func isRootViewControllerId(_ id: String) -> Bool {
    id == Context.shared.rootViewControllerId
}

//
//  convertOutletsToCode.swift
//  story2code
//
//  Created by Blazej Sleboda on 11/06/2025.
//

import StoryboardDecoder

func convertOutletsToCode(of view: ViewProtocol) -> [String] {
    var output = [String]()
    if Context.shared.debugEnabled {
        output.append(G.logLiteral + #function + " begin")
    }
    let outlets = view.connections?.compactMap { $0.connection as? Outlet }
    outlets?.forEach { outlet in
        output.append("$0.ibOutlet(&\(outlet.destination).\(outlet.property))")
        output.append(outlet.destination + "." + outlet.property + " = $0" )
    }
    Context.shared.ibOutlet.filter { outlet in
        outlet.viewId == view.id
    }.forEach { outlet in
        if outlet.isOutletToDestination {
            output.append("$0.\(outlet.property) = \(outlet.destination)")
        } else {
            output.append("$0.ibOutlet(&\(outlet.destination).\(outlet.property))")
        }
    }
    output.append(G.logLiteral + #function + " end")
    return output
}

func arrayViewIdToProperty(anyViewController: AnyViewController) -> [(viewId: String, property: String)]  {
    //guard let outlets = (anyViewController.nested.connections?.compactMap { $0 as? Outlet }) else { return [] }
    var outlets = (anyViewController.nested.connections?.compactMap { $0.connection as? Outlet })?
        .reduce(into: [(String, String)]()) { acc, outlet in acc.append((outlet.destination, outlet.property))
    } ?? []
    outlets.append((anyViewController.nested.rootView!.id, "view"))
    return outlets
}

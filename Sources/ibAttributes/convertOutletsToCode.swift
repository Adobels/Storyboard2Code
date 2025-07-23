//
//  convertOutletsToCode.swift
//  story2code
//
//  Created by Blazej Sleboda on 11/06/2025.
//

import StoryboardDecoder

func convertOutletsToCode(of element: ViewProtocol) -> [String] {
    let viewId = (element as! IBIdentifiable).id
    var output = [String]()
    Context.shared.ibOutlet.filter { outlet in
        outlet.viewId == viewId
    }.forEach { outlet in
        if outlet.isOutletToDestination {
            output.append("$0.\(outlet.property) = \(outlet.destination)")
        } else {
            output.append("$0.ibOutlet(&\(outlet.destination).\(outlet.property))")
        }
    }
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

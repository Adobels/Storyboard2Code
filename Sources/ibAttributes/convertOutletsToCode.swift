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
            output.append("$0.\(outlet.property) = \(sanitizedOutletName(from: outlet.destination)!)")
        } else {
            output.append("$0.ibOutlet(&\(sanitizedOutletName(from: outlet.destination)!).\(outlet.property))")
        }
    }
    return output
}

func arrayViewIdToProperty(anyViewController: AnyViewController) -> [(viewId: String, property: String)]  {
    //guard let outlets = (anyViewController.nested.connections?.compactMap { $0 as? Outlet }) else { return [] }
    var outlets = (anyViewController.nested.connections?.compactMap { $0.connection as? Outlet })?
        .reduce(into: [(String, String)]()) { acc, outlet in acc.append((sanitizedOutletName(from: outlet.destination)!, outlet.property) )
    } ?? []
    outlets.append((sanitizedOutletName(from: (anyViewController.nested.rootView as! IBIdentifiable).id)!, "view"))
    return outlets
}

func generateIbOutlet(for outlet: Outlet) -> String {
    "ibOutlet(&\(outlet.property))"
}

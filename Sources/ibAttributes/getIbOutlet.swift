//
//  getIbOutlet.swift
//  story2code
//
//  Created by Blazej Sleboda on 11/06/2025.
//

import StoryboardDecoder

func getIbOutlet(of element: ViewProtocol) -> [String] {
    guard let connections = element.connections else { return [] }
    let outlets = (connections.compactMap { $0.connection as? Outlet })
    var output = [String]()
    if !outlets.isEmpty {
        outlets.forEach { outlet in
            output.append("ibOutlet(&\(sanitizedOutletName(from: outlet.destination)!)" + "."  + "\(outlet.property)" + ")")
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

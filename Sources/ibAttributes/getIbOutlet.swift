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

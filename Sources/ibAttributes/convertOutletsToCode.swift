//
//  convertOutletsToCode.swift
//  story2code
//
//  Created by Blazej Sleboda on 11/06/2025.
//

import StoryboardDecoder

func convertOutletsToCode(of view: ViewProtocol) -> [String] {
    var strings = [String]()
    if Context.shared.debugEnabled {
        Context.shared.output.append(G.logLiteral + #function + ":" + String(#line) + " begin")
        defer { Context.shared.output.append(G.logLiteral + #function + ":" + String(#line) + " end") }
    }
    view.connections?.compactMap { $0.connection as? Outlet }.forEach { outlet in
        strings.append("$0.\(outlet.property).ibOutlet(&\(outlet.destination))")
    }
    return strings
}

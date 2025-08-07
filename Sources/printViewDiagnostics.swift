//
//  printViewDiagnostics.swift
//  story2code
//
//  Created by Blazej Sleboda on 26/07/2025.
//

import StoryboardDecoder

func printViewDiagnostics(of view: ViewProtocol, ctx: Context) -> [ParsingOutput.Item] {
    var results = [String]()
    guard ctx.debugViewMetaEnabled else { return [] }
    results.append(G.logLiteral)
    results.append("id: " + view.id)
    results.append("sid: " + sanitizedOutletName(from: view.id)!)
    if let value = view.userLabel { results.append("userLabel: " + value) }
    if let value = view.key { results.append("key: " + value) }
    return [results.joined(separator: ", ")]
}

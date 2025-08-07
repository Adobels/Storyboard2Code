//
//  sanitizeIds.swift
//  story2code
//
//  Created by Blazej Sleboda on 23/07/2025.
//

import StoryboardDecoder

@MainActor
func sanitizeIds(_ scene: Scene, ctx: Context) {
    let ids = generateListOfIBIdentifiable(of: scene)
    ids.forEach { id in
        ctx.output = ctx.output.map {
            var components = $0.components(separatedBy: G.logLiteral)
            components[0] = components[0].replacingOccurrences(of: id, with: sanitizedOutletName(from: id)!)
            return components.joined(separator: G.logLiteral)
        }
    }
}

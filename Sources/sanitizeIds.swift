//
//  sanitizeIds.swift
//  story2code
//
//  Created by Blazej Sleboda on 23/07/2025.
//


@MainActor
func sanitizeIds() {
    guard let scene = sb.document.scenes?.first else { fatalError() }
    let ids = generateListOfIBIdentifiable(of: scene)
    ids.forEach { id in
        Context.shared.output = Context.shared.output.map {
            var components = $0.components(separatedBy: G.logLiteral)
            components[0] = components[0].replacingOccurrences(of: id, with: sanitizedOutletName(from: id)!)
            return components.joined(separator: G.logLiteral)
        }
    }
}

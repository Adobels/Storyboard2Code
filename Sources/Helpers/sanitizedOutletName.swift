//
//  sanitizedOutletName.swift
//  story2code
//
//  Created by Blazej Sleboda on 11/06/2025.
//

import Foundation

func sanitizedOutletName(from outletName: String?) -> String? {
    guard let outletName else { return outletName }
    guard outletName.contains(where: { $0 == "-" }) else { return outletName } // guards against sanitizing outletNames which are properties
    let noDigits = outletName.replacingOccurrences(of: "[0-9]", with: "", options: .regularExpression)
    let withUnderscores = noDigits.replacingOccurrences(of: "-", with: "_")
    let components = withUnderscores
        .components(separatedBy: CharacterSet.letters.union(.init(charactersIn: "_")).inverted)
        .filter { !$0.isEmpty }
    guard !components.isEmpty else { return "unnamedOutlet" }
    var variableName = components[0].lowercased()
    for component in components.dropFirst() {
        variableName += component.capitalized
    }
    return variableName
}

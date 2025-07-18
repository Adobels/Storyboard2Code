//
//  convertDimesionRelationConstraintsToCode.swift
//  story2code
//
//  Created by Blazej Sleboda on 17/07/2025.
//

import Foundation

func convertDimesionRelationConstraintsToCode(
    firstItem: String?,
    firstAttribute: String,
    relation: String?,
    secondItem: String,
    secondItemAttribute: String,
    constant: Float?,
    multiplier: String?,
    priority: Float?,
    identifier: String?,
    id: String
) throws -> String {
    do {
        var components: [String] = []
        if let firstItem, !firstItem.isEmpty {
            components.append(sanitizedOutletName(from: firstItem)!)
        } else {
            components.append("$0")
        }
        components.append(convertLayoutAttributeToAnchor(firstAttribute))
        components.append(".constraint(")
        components.append(convertRelationToCode(relation))
        components.append(sanitizedOutletName(from: secondItem)!)
        components.append(convertLayoutAttributeToAnchor(secondItemAttribute))
        if let multiplier { components.append(": \(convertMultiplierToCode(multiplier))") }
        if let constant { components.append(": \(floatToString(constant))") }
        components.append(")")
        if let ibPriority = convertPriorityToCode(priority) { components.append(ibPriority) }
        if let ibIdentifier = convertIdentifierToCode(identifier) { components.append(ibIdentifier) }
        return components.joined()
    } catch {
        return "Error when converting constraint with id: \(id)"
    }
}

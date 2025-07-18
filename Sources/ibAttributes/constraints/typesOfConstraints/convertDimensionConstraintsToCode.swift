//
//  convertDimensionConstraintsToCode.swift
//  story2code
//
//  Created by Blazej Sleboda on 17/07/2025.
//

import Foundation

func convertDimensionConstraintsToCode(
    firstAttribute: String,
    relation: String?,
    constant: Float,
    priority: Float?,
    identifier: String?,
    id: String
) -> String {
    func convertRelationForSizeConstraint(_ relation: String?) throws -> String {
        switch relation ?? "equal" {
        case "equal": "equalToConstant"
        case "greaterThanOrEqual": "greaterThanOrEqualToConstant"
        case "lessThanOrEqual": "lessThanOrEqualToConstant"
        default: throw AppError.noName
        }
    }
    do {
        var components: [String] = []
        components.append("$0")
        components.append(convertLayoutAttributeToAnchor(firstAttribute))
        components.append(".constraint(")
        components.append(try convertRelationForSizeConstraint(relation))
        components.append(": \(floatToString(constant)))")
        if let ibPriority = convertPriorityToCode(priority) { components.append(ibPriority) }
        if let ibIdentifier = convertIdentifierToCode(identifier) { components.append(ibIdentifier) }
        return components.joined()
    } catch {
        return "Error when converting constraint with id: \(id)"
    }
}

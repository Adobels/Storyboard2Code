//
//  convertAlignmentConstraintWithMultiplierToCode.swift
//  story2code
//
//  Created by Blazej Sleboda on 17/07/2025.
//

import Foundation

func convertAlignmentConstraintWithMultiplierToCode(
    firstItem: String?,
    firstAttribute: String,
    relation: String?,
    secondItem: String,
    secondAttribute: String?,
    constant: Float?,
    multiplier: String,
    priority: Float?,
    identifier: String?
) -> (viewId: String, String)? {
    let viewId = firstItem!
    let constraintConverted = try! convertAlignmentConstraintWithMultiplierToCodeCore(
        firstItem: firstItem,
        firstAttribute: firstAttribute,
        relation: relation,
        secondItem: secondItem,
        secondAttribute: secondAttribute,
        constant: constant,
        multiplier: multiplier,
        priority: priority,
        identifier: identifier
    )
    return (viewId: viewId, constraintConverted)
}

func convertAlignmentConstraintWithMultiplierToCodeCore(
    firstItem: String?,
    firstAttribute: String,
    relation: String?,
    secondItem: String,
    secondAttribute: String?,
    constant: Float?,
    multiplier: String,
    priority: Float?,
    identifier: String?
) throws -> String {
    // NSLayoutConstraint(item: $0, attribute: .top, relatedBy: .equal, toItem: labelTop, attribute: .bottom, multiplier: 2, constant: 100).ibPriority(.init(240)).ibIdentifier("")
    var components: [String] = []
    components.append("NSLayoutConstraint(item: ")
    if let firstItem, !firstItem.isEmpty {
        components.append(firstItem)
    } else {
        components.append("$0")
    }
    components.append(", attribute: .\(firstAttribute)")
    components.append(", relatedBy: .\(relation ?? "equal")")
    components.append(", toItem: \(secondItem)")
    components.append(", attribute: .\(secondAttribute ?? "notAnAttribute")")
    components.append(", multiplier: \(multiplier)")
    components.append(", constant: \(constant ?? 0)")
    components.append(")")
    if let ibPriority = convertPriorityToCode(priority) { components.append(ibPriority) }
    if let ibIdentifier = convertIdentifierToCode(identifier) { components.append(ibIdentifier) }
    return components.joined()
}

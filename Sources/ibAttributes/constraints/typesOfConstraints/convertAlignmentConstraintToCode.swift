//
//  convertAlignmentConstraintToCode.swift
//  story2code
//
//  Created by Blazej Sleboda on 17/07/2025.
//

func convertAlignmentConstraintToCode(
    firstItem: String?,
    firstAttribute: String,
    relation: String?,
    secondItem: String,
    secondAttribute: String?,
    constant: Float?,
    multiplier: String?,
    priority: Float?,
    identifier: String?
) -> (viewId: String, String)? {
    let viewId = firstItem!
    let constraintConverted = try! convertAlignmentConstraintToCodeCore(
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

func convertAlignmentConstraintToCodeCore(
    firstItem: String?,
    firstAttribute: String,
    relation: String?,
    secondItem: String,
    secondAttribute: String?,
    constant: Float?,
    multiplier: String?,
    priority: Float?,
    identifier: String?
) throws -> String {
    var components: [String] = []
    if let firstItem, !firstItem.isEmpty {
        components.append(firstItem)
    } else {
        components.append("$0")
    }
    components.append(convertLayoutAttributeToAnchor("\(firstAttribute)"))
    components.append(".constraint(")
    components.append(convertRelationToCode(relation))
    components.append(secondItem)
    components.append(convertLayoutAttributeToAnchor("\(secondAttribute!)"))
    if let constant {
        components.append(", " + convertConstantToCode(constant))
    }
    if let multiplier, let multiplierCode = convertMultiplierToCode(multiplier){
        components.append(", " + multiplierCode)
    }
    components.append(")")
    if let ibPriority = convertPriorityToCode(priority) { components.append(ibPriority) }
    if let ibIdentifier = convertIdentifierToCode(identifier) { components.append(ibIdentifier) }
    return components.joined()
}

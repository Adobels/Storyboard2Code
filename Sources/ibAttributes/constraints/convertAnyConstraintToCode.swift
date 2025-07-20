//
//  convertAnyConstraintToCode.swift
//  story2code
//
//  Created by Blazej Sleboda on 17/07/2025.
//

func convertAnyConstraintToCode(firstItem: String?, firstAttribute: String, relation: String?, secondItem: String?, secondAttribute: String?, constant: Float?, multiplier: String?, priority: Float?, identifier: String?, id: String) -> String {
    let detectedConstraintType = constraintTypeDetector(
        firstAttribute: firstAttribute,
        secondItem: secondItem,
        secondAttribute: secondAttribute,
        multiplier: multiplier
    )
    return switch detectedConstraintType {
    case .dimension:
        convertDimensionConstraintsToCode(
            firstAttribute: firstAttribute,
            relation: relation,
            constant: constant!,
            priority: priority,
            identifier: identifier,
            id: id
        )
    case .dimensionRelation:
        try! convertDimesionRelationConstraintsToCode(
            firstItem: firstItem,
            firstAttribute: firstAttribute,
            relation: relation,
            secondItem: secondItem!,
            secondItemAttribute: secondAttribute!,
            constant: constant,
            multiplier: multiplier,
            priority: priority,
            identifier: identifier,
            id: id
        )
    case .alignmentRelation:
        try! convertAlignmentConstraintToCodeCore(
            firstItem: firstItem,
            firstAttribute: firstAttribute,
            relation: relation,
            secondItem: secondItem!,
            secondAttribute: secondAttribute,
            constant: constant,
            multiplier: multiplier,
            priority: priority,
            identifier: identifier
        )
    case .alignmentRelationWithMultiplier: try! convertAlignmentConstraintWithMultiplierToCodeCore(
        firstItem: firstItem,
        firstAttribute: firstAttribute,
        relation: relation,
        secondItem: secondItem!,
        secondAttribute: secondAttribute,
        constant: constant,
        multiplier: multiplier!,
        priority: priority,
        identifier: identifier
    )
    }
}

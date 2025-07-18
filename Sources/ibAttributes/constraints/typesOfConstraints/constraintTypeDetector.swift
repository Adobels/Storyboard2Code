//
//  File.swift
//  story2code
//
//  Created by Blazej Sleboda on 17/07/2025.
//

import Foundation

func constraintTypeDetector(
    firstAttribute: String?,
    secondItem: String?,
    secondAttribute: String?,
    multiplier: String?,
) -> ConstraintType {
    guard let secondItem else { return .dimension }
    let hasDimensionAttribute = [firstAttribute, secondAttribute].contains(where: {
        ["width", "height"].contains($0)
    })
    if hasDimensionAttribute {
        return .dimensionRelation
    }
    return if let multiplier {
        .alignmentRelationWithMultiplier
    } else {
        .alignmentRelation
    }
}

enum ConstraintType {
    case dimension
    case dimensionRelation
    case alignmentRelation
    case alignmentRelationWithMultiplier
}

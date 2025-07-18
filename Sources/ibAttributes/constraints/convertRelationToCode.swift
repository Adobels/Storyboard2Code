//
//  convertRelationToCode.swift
//  story2code
//
//  Created by Blazej Sleboda on 17/07/2025.
//

import StoryboardDecoder

func convertRelationToCode(_ relation: Constraint.Relation) -> String? {
    convertRelationToCode("\(relation)")
}

func convertRelationToCode(_ relation: String?) -> String {
    switch relation ?? "equal" {
    case "lessThanOrEqual": "lessThanOrEqualTo: "
    case "greaterThanOrEqual": "greaterThanOrEqualTo: "
    case "equal": "equalTo: "
    default: fatalError()
    }
}

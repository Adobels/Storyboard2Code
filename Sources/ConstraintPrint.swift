//
//  File 2.swift
//  story2code
//
//  Created by Blazej Sleboda on 04/06/2025.
//
import IBDecodable

func constraintLayoutAttribute(_ attribute: Constraint.LayoutAttribute?) -> String {
    guard let attribute else { return "attribute is nil" }
    return switch attribute {
    case .left: "leftAnchor"
    case .right: "rightAnchor"
    case .top: "topAnchor"
    case .bottom: "bottomAnchor"
    case .leading: "leadingAnchor"
    case .trailing: "trailingAnchor"
    case .width: "widthAnchor"
    case .height: "heightAnchor"
    case .centerX: "centerXAnchor"
    case .centerY: "centerYAnchor"
    case .leftMargin: "layoutMarginsGuide.leftAnchor"
    case .rightMargin: "layoutMarginsGuide.rightAnchor"
    case .topMargin: "layoutMarginsGuide.topAnchor"
    case .bottomMargin: "layoutMarginsGuide.bottomAnchor"
    case .leadingMargin: "layoutMarginsGuide.leadingAnchor"
    case .trailingMargin: "layoutMarginsGuide.trailingAnchor"
    case .other(let string): "other"
    }
}

func printConstraintRelationOpen(_ relation: Constraint.Relation?) -> String {
    guard let relation else { return "relation is nil" }
    return switch relation {
    case .lessThanOrEqual: "constraint(lessThanOrEqualTo:"
    case .greaterThanOrEqual: "constraint(greaterThanOrEqualTo:"
    case .equal: "constraint(equalTo:"
    case .other(let string): "constraint(other:"
    }
}

func printConstraintRelationClose() -> String { ")" }

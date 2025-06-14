//
//  File 2.swift
//  story2code
//
//  Created by Blazej Sleboda on 04/06/2025.
//
import StoryboardDecoder

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
    case .lessThanOrEqual: "constraint(lessThanOrEqualTo: "
    case .greaterThanOrEqual: "constraint(greaterThanOrEqualTo: "
    case .equal: "constraint(equalTo: "
    case .other(let string): "constraint(other: "
    }
    "constraint(lessThanOrEqualTo: secondAnchor, const"
}

struct ContextForIBConstraints {
    var constraintParentViewId: String
    var arrayLayoutGuideIdToParentViewId: [LayoutGuideIdToParentViewId]
    var arrayRootViewFlattened: [ViewPropertiesForParsing]
}

struct S2CConstraint {

    var firstItem: String?
    let firstAttribute: Constraint.LayoutAttribute
    var relation: Constraint.Relation
    var secondItem: String?
    let secondAttribute: Constraint.LayoutAttribute?
    let multiplier: String?
    let priority: Int?
    var constant: Int?
    let identifier: String?
    let id: String

    mutating func convertToCode(with context: ContextForIBConstraints) -> (viewId: String, constraint: String) {
        if let code = convertConstraintWidthOrHeightToUIViewKitCode() {
            return (firstItem ?? context.constraintParentViewId, code)
        } else if let code = convertConstraintRelationBetweenItemsUIViewKitCode(with: context) {
            return code
        } else {
            fatalError()
        }
    }

    mutating func convertConstraintRelationBetweenItemsUIViewKitCode(with context: ContextForIBConstraints) -> (viewId: String, String)? {
        guard var secondItem else {
            return nil
        }
        reverseFirstAndSecondItemIfNeeded(with: context)
        let firstItemLayoutGuide: LayoutGuideIdToParentViewId? = context.arrayLayoutGuideIdToParentViewId.first(where: { item in
            item.layoutGuideId == firstItem
        })
        let secondItemLayoutGuide: LayoutGuideIdToParentViewId? = context.arrayLayoutGuideIdToParentViewId.first(where: { item in
            item.layoutGuideId == secondItem
        })
        let secondItemResolved = secondItemLayoutGuide?.parentViewId ?? secondItem
        var components: [String] = []
        components.append("$0")
        if let firstItemLayoutGuide {
            components.append(".\(storyboardLayoutGuideKeyToCode(firstItemLayoutGuide))")
        }
        components.append(".\(firstAttribute)Anchor")
        components.append(".constraint(")
        components.append("\(relation): ")
        components.append("\(sanitizedOutletName(from: secondItemResolved)!)")
        if let secondItemLayoutGuide {
            components.append(".\(storyboardLayoutGuideKeyToCode(secondItemLayoutGuide))")
        }
        components.append(".\(secondAttribute!)Anchor")
        if let constant {
            components.append(", constant: \(constant)")
        }
        components.append(")")
        if let priority { components.append(".ibPriority(.init\(priority)") }
        if let identifier { components.append(".ibIdentifier(\"\(identifier)\")") }
        return (viewId: sanitizedOutletName(from: firstItemLayoutGuide?.parentViewId ?? firstItem ?? context.constraintParentViewId)!, components.joined())
    }

    func convertConstraintWidthOrHeightToUIViewKitCode() -> String? {
        guard secondItem == nil else { return nil }
        var components: [String] = []
        components.append("$0")
        if firstAttribute == .height {
            components.append(".height(")
        } else if firstAttribute == .width {
            components.append(".width(")
        } else {
            return nil
        }
        components.append(".\(relation)ToConstant: \(constant ?? 0)")
        components.append(")")
        if let priority { components.append(".ibPriority(.init\(priority)") }
        if let identifier { components.append(".ibIdentifier(\"\(identifier)\")") }
        return components.joined()
    }

    mutating func reverseFirstAndSecondItemIfNeeded(with context: ContextForIBConstraints) {
        if needReverseFirstAndSecondItem(with: context) {
            let firstItem = firstItem
            self.firstItem = secondItem!
            self.secondItem = firstItem
            if let constant { self.constant = -constant }
            switch relation {
            case .lessThanOrEqual: relation = .greaterThanOrEqual
            case .greaterThanOrEqual: relation = .lessThanOrEqual
            case .equal, .other: break
            }
        }
    }

    func needReverseFirstAndSecondItem(with context: ContextForIBConstraints) -> Bool {
        guard let secondItem else { return false }
        let firstItemIndex = context.arrayLayoutGuideIdToParentViewId.firstIndex { item in
            item.layoutGuideId == firstItem
        } ?? context.arrayRootViewFlattened.firstIndex(where: { item in
            item.id == context.constraintParentViewId
        })!
        let secondItemIndex = context.arrayLayoutGuideIdToParentViewId.firstIndex { item in
            item.layoutGuideId == secondItem
        } ?? context.arrayRootViewFlattened.firstIndex(where: { item in
            item.id == secondItem
        })!
        return secondItemIndex < firstItemIndex
    }

    func storyboardLayoutGuideKeyToCode(_ layoutGuide: LayoutGuideIdToParentViewId) -> String {
        switch layoutGuide.layoutGuideKey {
        case "safeArea": "safeAreaLayoutGuide"
        case "keyboard": "keyboardLayoutGuide"
        default: fatalError()
        }
    }
}

struct LayoutGuideIdToParentViewId {
    let layoutGuideId: String
    let layoutGuideKey: String
    let parentViewId: String
}

struct ViewPropertiesForParsing {
    let id: String
    let customClass: String?
    let elementClass: String
    let verticalPositionIndex: Int
    func customClassOrElementClass() -> String {
        customClass ?? elementClass
    }
}


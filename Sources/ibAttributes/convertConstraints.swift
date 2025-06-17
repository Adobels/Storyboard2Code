//
//  File 2.swift
//  story2code
//
//  Created by Blazej Sleboda on 04/06/2025.
//
import StoryboardDecoder

private func constraintLayoutAttribute(_ attribute: Constraint.LayoutAttribute?) -> String {
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

private func transformRelationToString(_ relation: Constraint.Relation?) -> String {
    guard let relation else { return "relation is nil" }
    return switch relation {
    case .lessThanOrEqual: "lessThanOrEqualTo: "
    case .greaterThanOrEqual: "greaterThanOrEqualTo: "
    case .equal: "equalTo: "
    case .other(let string): "other: "
    }
    "lessThanOrEqualTo: secondAnchor, const"
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
        guard secondItem != nil else { return nil }
        if firstItem == nil {
            firstItem = context.constraintParentViewId
        }
        reverseFirstAndSecondItemIfNeeded(with: context)
        let firstItemLayoutGuide: LayoutGuideIdToParentViewId? = context.arrayLayoutGuideIdToParentViewId.first(where: { item in
            item.layoutGuideId == firstItem
        })
        if let firstItemLayoutGuide {
            firstItem = firstItemLayoutGuide.parentViewId
        }
        let secondItemLayoutGuide: LayoutGuideIdToParentViewId? = context.arrayLayoutGuideIdToParentViewId.first(where: { item in
            item.layoutGuideId == secondItem
        })
        if let secondItemLayoutGuide {
            secondItem = secondItemLayoutGuide.parentViewId
        }
        guard let firstItem else { fatalError() }
        guard let secondItem else { fatalError() }
        var components: [String] = []
        components.append("$0")
        if let firstItemLayoutGuide {
            components.append(".\(storyboardLayoutGuideKeyToCode(firstItemLayoutGuide))")
        }
        components.append(".\(firstAttribute)Anchor")
        components.append(".constraint(")
        components.append("\(transformRelationToString(relation))")
        components.append("\(sanitizedOutletName(from: secondItem)!)")
        if let secondItemLayoutGuide {
            components.append(".\(storyboardLayoutGuideKeyToCode(secondItemLayoutGuide))")
        }
        components.append(".\(secondAttribute!)Anchor")
        if let constant {
            components.append(", constant: \(constant)")
        }
        components.append(")")
        if let ibPriority = convertPriorityToCode() { components.append(ibPriority) }
        if let ibIdentifier = convertIdentifierToCode() { components.append(ibIdentifier) }
        let viewId = sanitizedOutletName(from: firstItem)!
        let constraintConverted = components.joined()
        Context.shared.arrayConstrains.append((viewId: viewId, constraintConverted))
        return (viewId: viewId, constraintConverted)
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
        if let ibPriority = convertPriorityToCode() { components.append(ibPriority) }
        if let ibIdentifier = convertIdentifierToCode() { components.append(ibIdentifier) }
        return components.joined()
    }

    mutating func reverseFirstAndSecondItemIfNeeded(with context: ContextForIBConstraints) {
        if needReverseFirstAndSecondItem(with: context) {
            let firstItem = firstItem ?? context.constraintParentViewId
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
        let firstItemResolved = context.arrayLayoutGuideIdToParentViewId.first { item in
            item.layoutGuideId == firstItem
        }?.parentViewId ?? firstItem ?? context.constraintParentViewId
        let firstItemIndex = context.arrayRootViewFlattened.firstIndex(where: { item in
            item.id == firstItemResolved
        })!

        let secondItemResolved = context.arrayLayoutGuideIdToParentViewId.first { item in
            item.layoutGuideId == secondItem
        }?.parentViewId ?? secondItem
        let secondItemIndex = context.arrayRootViewFlattened.firstIndex { item in
            item.id == secondItemResolved
        }!
        return firstItemIndex < secondItemIndex
    }

    func storyboardLayoutGuideKeyToCode(_ layoutGuide: LayoutGuideIdToParentViewId) -> String {
        switch layoutGuide.layoutGuideKey {
        case "safeArea": "safeAreaLayoutGuide"
        case "keyboard": "keyboardLayoutGuide"
        default: fatalError()
        }
    }
}

private extension S2CConstraint {
    func convertPriorityToCode() -> String? {
        if let priority { ".ibPriority(.init(\(priority)))" } else { nil }
    }
    func convertIdentifierToCode() -> String? {
        if let identifier { ".ibIdentifier(\"\(identifier)\")" } else { nil }
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


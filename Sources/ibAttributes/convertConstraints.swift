//
//  File 2.swift
//  story2code
//
//  Created by Blazej Sleboda on 04/06/2025.
//
import StoryboardDecoder
import math_h

struct S2CConstraint {

    var firstItem: String?
    var firstAttribute: Constraint.LayoutAttribute
    var relation: Constraint.Relation
    var secondItem: String?
    var secondAttribute: Constraint.LayoutAttribute?
    let multiplier: String?
    let priority: Float?
    var constant: Float?
    let identifier: String?
    let id: String

    mutating func convertToCode(with context: ContextForIBConstraints) -> (viewId: String, constraint: String) {
        if let code = convertConstraintWidthOrHeightToUIViewKitCode() {
            return (sanitizedOutletName(from: firstItem ?? context.constraintParentViewId)!, code)
        } else if let code = convertConstraintRelationBetweenItemsUIViewKitCode(with: context) {
            return code
        } else {
            fatalError()
        }
    }

    fileprivate func extractedFunc1(_ firstItemLayoutGuide: LayoutGuideIdToParentViewId?, _ secondItem: String, _ secondItemLayoutGuide: LayoutGuideIdToParentViewId?, _ firstItem: String) -> (viewId: String, String)? {
        convertConstraintToCode(
            firstItem,
            storyboardLayoutGuideKeyToCode(firstItemLayoutGuide?.layoutGuideKey),
            "\(firstAttribute)",
            transformRelationToString(relation),
            secondItem,
            storyboardLayoutGuideKeyToCode(secondItemLayoutGuide?.layoutGuideKey),
            { if let secondAttribute { "\(firstAttribute)" } else { nil } }(),
            constant: constant,
            multiplier: multiplier,
            priority: priority,
            identifier: identifier
        )
    }


    private mutating func convertConstraintRelationBetweenItemsUIViewKitCode(with context: ContextForIBConstraints) -> (viewId: String, String)? {
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
        guard var firstItem else { fatalError() }
        guard var secondItem else { fatalError() }
        let secondItemViewControlerOutlet = Context.shared.viewControllerIBOutlets.first(where: { $0.viewId == sanitizedOutletName(from: secondItem)! })
        if let secondItemViewControlerOutlet {
            secondItem = secondItemViewControlerOutlet.property
        }
        let result = extractedFunc1(firstItemLayoutGuide, secondItem, secondItemLayoutGuide, firstItem)
        if let result  {
            Context.shared.arrayConstrains.append(result)
        }
        return result
    }

    private func convertConstraintWidthOrHeightToUIViewKitCode() -> String? {
        guard secondItem == nil else { return nil }
        var components: [String] = []
        components.append("$0")
        if firstAttribute == .height {
            components.append(".heightAnchor")
        } else if firstAttribute == .width {
            components.append(".widthAnchor")
        } else {
            fatalError()
        }
        components.append(".constraint(\(relation)ToConstant: \(floatToString(constant ?? 0)))")
        if let ibPriority = convertPriority(priority) { components.append(ibPriority) }
        if let ibIdentifier = convertIdentifierToCode(identifier) { components.append(ibIdentifier) }
        return components.joined()
    }

    private mutating func reverseFirstAndSecondItemIfNeeded(with context: ContextForIBConstraints) {
        guard needReverseFirstAndSecondItem(with: context) else { return }
        let firstItem = firstItem ?? context.constraintParentViewId
        let tmpFirstAttribute = firstAttribute
        self.firstItem = secondItem!
        self.firstAttribute = secondAttribute!
        self.secondItem = firstItem
        self.secondAttribute = tmpFirstAttribute
        if let constant { self.constant = -constant }
        switch relation {
        case .lessThanOrEqual: relation = .greaterThanOrEqual
        case .greaterThanOrEqual: relation = .lessThanOrEqual
        case .equal, .other: break
        }
    }

    private func needReverseFirstAndSecondItem(with context: ContextForIBConstraints) -> Bool {
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

//    private func storyboardLayoutGuideKeyToCode(_ layoutGuide: LayoutGuideIdToParentViewId) -> String {
//        switch layoutGuide.layoutGuideKey {
//        case "safeArea": "safeAreaLayoutGuide"
//        case "keyboard": "keyboardLayoutGuide"
//        default: fatalError()
//        }
//    }
}

func convertConstraintToCode(
    _ firstItem: String,
    _ firstItemLayoutGuide: String?,
    _ firstAttribute: String,
    _ relation: String,
    _ secondItem: String,
    _ secondItemLayoutGuide: String?,
    _ secondAttribute: String?,
    constant: Float?,
    multiplier: String?,
    priority: Float?,
    identifier: String?
) -> (viewId: String, String)? {
    var components: [String] = []
    components.append("$0")
    if let firstItemLayoutGuide, let decoded = storyboardLayoutGuideKeyToCode(firstItemLayoutGuide) {
        components.append("." + decoded)
    }
    components.append(convertLayoutAttributeToAnchor("\(firstAttribute)"))
    components.append(".constraint(")
    components.append("\(transformRelationToString(relation))")
    components.append("\(sanitizedOutletName(from: secondItem)!)")
    if let secondItemLayoutGuide {
        components.append(".\(storyboardLayoutGuideKeyToCode(secondItemLayoutGuide))")
    }
    components.append(convertLayoutAttributeToAnchor("\(secondAttribute!)"))
    if let constant {
        components.append(", " + convertConstant(constant))
    }
    if let multiplier, let multiplierCode = convertMultiplierToCode(multiplier){
        components.append(", " + multiplierCode)
    }
    components.append(")")
    if let ibPriority = convertPriority(priority) { components.append(ibPriority) }
    if let ibIdentifier = convertIdentifierToCode(identifier) { components.append(ibIdentifier) }
    let viewId = sanitizedOutletName(from: firstItem)!
    let constraintConverted = components.joined()
    return (viewId: viewId, constraintConverted)
}

func storyboardLayoutGuideKeyToCode(_ layoutGuideKey: String?) -> String? {
    guard let layoutGuideKey else { return nil }
    guard !layoutGuideKey.isEmpty else { return nil }
    return switch layoutGuideKey {
    case "safeArea": "safeAreaLayoutGuide"
    case "keyboard": "keyboardLayoutGuide"
    default: fatalError()
    }
}

func convertLayoutAttribute(_ layoutAttribute: String) -> String {
    return switch layoutAttribute {
    case "topMargin": "top"
    case "leadingMargin": "leading"
    case "trailingMargin": "trailing"
    case "leftMargin": "left"
    case "rightMargin": "right"
    case "bottomMargin": "bottom"
    default: layoutAttribute
    }
}

//func convertLayoutAttributeToAnchor(_ layoutAttribute: String) -> String? {
//    guard !layoutAttribute.isEmpty else { return  nil }
//    return "." + convertLayoutAttribute(layoutAttribute) + "Anchor"
//}

func convertIdentifierToCode(_ identifier: String?) -> String? {
    guard let identifier, !identifier.isEmpty else { return nil }
    return ".ibIdentifier(\"" + identifier + "\")"
}

func convertMultiplierToCode(_ multiplier: String?) -> String? {
    guard let multiplier, !multiplier.isEmpty else { return nil }
    guard let multiplier = convertMultiplierToFloat(multiplier) else { return "" }
    return "multiplier: " + String(floatToString(multiplier))
    func convertMultiplierToFloat(_ multiplier: String?) -> Float? {
        guard let multiplier, multiplier != nil else { return nil }
        let components = multiplier.components(separatedBy: ":")
        if components.count > 1 {
            let mulitplierValue = Float(components.first!)! / Float(components.last!)!
            return mulitplierValue
        } else {
            return .init(multiplier)!
        }
    }
}

func convertConstant(_ constant: Float) -> String {
    "constant: " + floatToString(constant)
}

func convertPriority(_ priority: Float?) -> String? {
    guard let priority else { return nil }
    return ".ibPriority(" + convertPriorityValue(Int(priority)) + ")"
    func convertPriorityValue(_ value: Int) -> String {
        if value == 250 {
            ".defaultLow"
        } else if value == 750 {
            ".defaultHigh"
        } else if value == 1000 {
            ".required"
        } else {
            ".init(" + String(value) + ")"
        }
    }
}

struct ContextForIBConstraints {
    var constraintParentViewId: String
    var arrayLayoutGuideIdToParentViewId: [LayoutGuideIdToParentViewId]
    var arrayRootViewFlattened: [ViewPropertiesForParsing]
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

func convertLayoutAttributeToAnchor(_ layoutAttribute: String) -> String {
    return switch layoutAttribute {
    case "left": ".leftAnchor"
    case "right": ".rightAnchor"
    case "top": ".topAnchor"
    case "bottom": ".bottomAnchor"
    case "leading": ".leadingAnchor"
    case "trailing": ".trailingAnchor"
    case "width": ".widthAnchor"
    case "height": ".heightAnchor"
    case "centerX": ".centerXAnchor"
    case "centerY": ".centerYAnchor"
    case "leftMargin": ".layoutMarginsGuide.leftAnchor"
    case "rightMargin": ".layoutMarginsGuide.rightAnchor"
    case "topMargin": ".layoutMarginsGuide.topAnchor"
    case "bottomMargin": ".layoutMarginsGuide.bottomAnchor"
    case "leadingMargin": ".layoutMarginsGuide.leadingAnchor"
    case "trailingMargin": ".layoutMarginsGuide.trailingAnchor"
    default: ".other"
    }
}

func transformRelationToString(_ relation: Constraint.Relation) -> String {
    transformRelationToString("\(relation)")
}

func transformRelationToString(_ relation: String?) -> String {
    guard let relation else { return "relation is nil" }
    return switch relation {
    case "lessThanOrEqual": "lessThanOrEqualTo: "
    case "greaterThanOrEqual": "greaterThanOrEqualTo: "
    case "equal": "equalTo: "
    case "other": "other: "
    default: fatalError()
    }
}

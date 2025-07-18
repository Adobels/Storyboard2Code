//
//  convertConstraints.swift
//  story2code
//
//  Created by Blazej Sleboda on 04/06/2025.
//

import StoryboardDecoder

func convertResolvedConstraintToCode(
    resolvedFirstItem: String,
    resolvedFirstItemLayoutGuideKey: String?,
    resolvedFirstAttribute: String,
    relation: String?,
    resolvedSecondItem: String,
    resolvedSecondItemLayoutGuideKey: String?,
    resolvedSecondAttribute: String?,
    constant: Float?,
    multiplier: String?,
    priority: Float?,
    identifier: String?
) -> (viewId: String, String)? {
    var components: [String] = []
    components.append("$0")
    if let resolvedFirstItemLayoutGuideKey, let decoded = storyboardLayoutGuideKeyToCode(resolvedFirstItemLayoutGuideKey) {
        components.append("." + decoded)
    }
    components.append(convertLayoutAttributeToAnchor("\(resolvedFirstAttribute)"))
    components.append(".constraint(")
    components.append("\(convertRelationToCode(relation))")
    components.append("\(sanitizedOutletName(from: resolvedSecondItem)!)")
    if let resolvedSecondItemLayoutGuideKey {
        components.append(".\(storyboardLayoutGuideKeyToCode(resolvedSecondItemLayoutGuideKey))")
    }
    components.append(convertLayoutAttributeToAnchor("\(resolvedSecondAttribute!)"))
    if let constant {
        components.append(", " + convertConstantToCode(constant))
    }
    if let multiplier, let multiplierCode = convertMultiplierToCode(multiplier){
        components.append(", " + multiplierCode)
    }
    components.append(")")
    if let ibPriority = convertPriorityToCode(priority) { components.append(ibPriority) }
    if let ibIdentifier = convertIdentifierToCode(identifier) { components.append(ibIdentifier) }
    let viewId = sanitizedOutletName(from: resolvedFirstItem)!
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

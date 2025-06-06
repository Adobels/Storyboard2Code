//
//  parseUserDefinedRuntimeAttributes.swift
//  story2code
//
//  Created by Blazej Sleboda on 05/06/2025.
//

import StoryboardDecoder

@MainActor
func parseUserDefinedRuntimeAttributes(of uiView: ViewProtocol) -> [String] {

    guard let userDefinedRuntimeAttributes = uiView.userDefinedRuntimeAttributes else { return [] }

    var attributes: [String] = []
    // occurences was calculated with :
    // grep -r 'keyPath="' --include="*.storyboard" . | sed -n 's/.*keyPath="\([^"]*\)".*/\1/p' | sort | uniq -c | sort -nr
    userDefinedRuntimeAttributes.forEach { attribute in
        if attribute.keyPath == "locKey" { // 788 occurences
            // "locKey always has a value, checked with regex in the project "
            // <userDefinedRuntimeAttribute[^>]*keyPath="locKey"(?![^>]*value=)
            attributes.append("text = \(fixLocKey(value: attribute.value!))")
        } else if attribute.keyPath == "textColorName" { // 545 occurences
            attributes.append("textColor = Colors.\(attribute.value!)")
        } else if attribute.keyPath == "tintColorName" { // 288 occurences
            attributes.append("tintColor = Colors.\(attribute.value!)")
        } else if attribute.keyPath == "textLineSpacing" { // 160 occurences
            attributes.append("\(attribute.keyPath) = \(attribute.value!)")
        } else if attribute.keyPath == "locKeyPlaceholder" { // 112 occurences
            attributes.append("\(attribute.keyPath) = \(attribute.value!)")
        } else if attribute.keyPath == "themeStyle" { // 104 occurences
            attributes.append("\(attribute.keyPath) = \(attribute.value!)")
        } else if attribute.keyPath == "loaderPositionName" { // 94 occurences
            attributes.append("loaderPosition = .\(attribute.value!)")
        } else if attribute.keyPath == "cornerRadius" { // 88 occurences
            attributes.append("\(attribute.keyPath) = \(attribute.value!)")
        } else if attribute.keyPath == "loaderSizeName" { // 68 occurences
            attributes.append("loaderSize = .\(attribute.value!)")
        } else if attribute.keyPath == "themeParent" { // 44 occurences
            attributes.append("\(attribute.keyPath) = \(attribute.value!)")
        } else if attribute.keyPath == "layer.cornerRadius" { // 20 occurences
            attributes.append("\(attribute.keyPath) = \(attribute.value!)")
        } else if attribute.keyPath == "backgroundColorName" { // 20 occurences
            attributes.append("backgroundColor = Colors.\(attribute.value!)")
        } else if attribute.keyPath == "borderColorName" { // 18 occurences
            attributes.append("borderColor = Colors.\(attribute.value!)")
        } else if attribute.keyPath == "leftSeparatorInset" { // 12 occurences
            attributes.append("\(attribute.keyPath) = \(attribute.value!)")
        } else if attribute.keyPath == "borderWidth" { // 12 occurences
            attributes.append("\(attribute.keyPath) = \(attribute.value!)")
        } else if attribute.keyPath == "progress" { // 10 occurences
            attributes.append("\(attribute.keyPath) = \(attribute.value!)")
        } else if attribute.keyPath == "layer.borderWidth" { // 8 occurences
            attributes.append("\(attribute.keyPath) = \(attribute.value!)")
        } else if attribute.keyPath == "shadowY" { // 6 occurences
            attributes.append("\(attribute.keyPath) = \(attribute.value!)")
        } else if attribute.keyPath == "shadowX" { // 6 occurences
            attributes.append("\(attribute.keyPath) = \(attribute.value!)")
        } else if attribute.keyPath == "shadowSpread" { // 6 occurences
            attributes.append("\(attribute.keyPath) = \(attribute.value!)")
        } else if attribute.keyPath == "shadowColorName" { // 6 occurences
            attributes.append("shadowColor = Colors.\(attribute.value!)")
        } else if attribute.keyPath == "shadowBlur" { // 6 occurences
            attributes.append("\(attribute.keyPath) = \(attribute.value!)")
        } else if attribute.keyPath == "prefixLocKey" { // 6 occurences
            attributes.append("\(attribute.keyPath) = \(attribute.value!)")
        } else if attribute.keyPath == "placeholderLocKey" { // 6 occurences
            attributes.append("\(attribute.keyPath) = \(attribute.value!)")
        } else if attribute.keyPath == "shadowAlpha" { // 4 occurences
            attributes.append("\(attribute.keyPath) = \(attribute.value!)")
        } else if attribute.keyPath == "rightSeparatorInset" { // 4 occurences
            attributes.append("\(attribute.keyPath) = \(attribute.value!)")
        } else if attribute.keyPath == "followRoundedCorner" { // 4 occurences
            attributes.append("\(attribute.keyPath) = \(attribute.value!)")
        } else if attribute.keyPath == "topCornerRadius" { // 2 occurences
            attributes.append("\(attribute.keyPath) = \(attribute.value!)")
        } else if attribute.keyPath == "startColor" { // 2 occurences
            attributes.append("\(attribute.keyPath) = \(attribute.value!)")
        } else if attribute.keyPath == "loaderMargin" { // 2 occurences
            attributes.append("\(attribute.keyPath) = \(attribute.value!)")
        } else if attribute.keyPath == "lineWidth" { // 2 occurences
            attributes.append("\(attribute.keyPath) = \(attribute.value!)")
        } else if attribute.keyPath == "isShadowEnabled" { // 2 occurences
            attributes.append("\(attribute.keyPath) = \(attribute.value!)")
        } else if attribute.keyPath == "horizontal" { // 2 occurences
            attributes.append("\(attribute.keyPath) = \(attribute.value!)")
        } else if attribute.keyPath == "endColor" { // 2 occurences
            attributes.append("\(attribute.keyPath) = \(attribute.value!)")
        } else if attribute.keyPath == "decimalSeparator" { // 2 occurences
            attributes.append("\(attribute.keyPath) = \(attribute.value!)")
        } else if attribute.keyPath == "accessibilityIdentifier" { // 2 occurences
            attributes.append("\(attribute.keyPath) = \(attribute.value!)")
        } else {
            attributes.append("\(attribute.keyPath) = \(attribute.value!)")
        }
    }
    return attributes
}

private func fixLocKey(value: Any?) -> String {
    guard let value, let stringValue = value as? String else { return "error" }
    var locKeyComponents = stringValue.split(separator: .init(".")).map { String($0) }
    guard let lastComponent = locKeyComponents.popLast() else {
        fatalError("I supose that locKey always has two or more components separated by dot")
    }
    locKeyComponents = locKeyComponents.map { $0.capitalized }
    locKeyComponents.append(lastComponent)
    return "Loc." + locKeyComponents.joined(separator: ".")
}

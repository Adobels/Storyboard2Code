//
//  convertLayoutAttributeToAnchor.swift
//  story2code
//
//  Created by Blazej Sleboda on 17/07/2025.
//

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

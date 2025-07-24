//
//  fontDescriptionToCode.swift
//  story2code
//
//  Created by Blazej Sleboda on 27/06/2025.
//

import StoryboardDecoder

func fontDescriptionToCode(_ fontDescription: FontDescription) -> String {
    return if case .system(let value) = fontDescription {
        if value.type == "boldSystem" {
            ".init(weight: .bold, size: \(floatToString(value.pointSize)))"
        } else if value.weight == "medium" {
            ".init(weight: .medium, size: \(floatToString(value.pointSize)))"
        } else if value.type == "system" {
            ".init(weight: .regular, size: \(floatToString(value.pointSize)))"
        } else {
            "\(fontDescription)"
        }
    } else {
        "\(fontDescription)"
    }
}

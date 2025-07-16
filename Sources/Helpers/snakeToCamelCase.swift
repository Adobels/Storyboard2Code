//
//  snakeToCamelCase.swift
//  story2code
//
//  Created by Blazej Sleboda on 15/07/2025.
//

func snakeToCamelCase(_ string: String) -> String {
    let components = string.split(separator: "_")
    guard let first = components.first?.lowercased() else { return "" }
    let rest = components.dropFirst().map { $0.capitalized }
    return ([first] + rest).joined()
}

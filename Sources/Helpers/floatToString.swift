//
//  floatToString.swift
//  story2code
//
//  Created by Blazej Sleboda on 23/06/2025.
//

import math_h

func floatToString(_ value: Float) -> String {
    if value == floorf(value) {
        "\(Int(value))"
    } else {
        "\(value)"
    }
}

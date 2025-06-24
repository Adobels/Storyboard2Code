//
//  resistancePriorityToCode.swift
//  story2code
//
//  Created by Blazej Sleboda on 24/06/2025.
//

import Foundation

func resistancePriorityToCode(_ value: Int) -> String {
    if value == 1000 {
        ".required"
    } else {
        ".init(\(value))"
    }
}

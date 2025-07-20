//
//  stringOrNil.swift
//  story2code
//
//  Created by Blazej Sleboda on 17/07/2025.
//


func stringOrNil(from object: Any?) -> String? {
    object.map { "\($0)" }
}

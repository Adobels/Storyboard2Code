//
//  StandardLibraryExtensions.swift
//  story2code
//
//  Created by Blazej Sleboda on 04/08/2025.
//

extension Array<String> {

    mutating func appendToLastElement(_ value: String) {
        append(removeLast() + value)
    }
}

extension Collection {
    var hasContent: Bool { !isEmpty }
}

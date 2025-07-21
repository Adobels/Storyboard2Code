//
//  DimensionRelationConstraintsTests.swift
//  story2code
//
//  Created by Blazej Sleboda on 16/07/2025.
//

import Testing
import Foundation
import StoryboardDecoder
@testable import story2code

@MainActor
@Suite("Dimension Relation Constraints Tests")
struct DimensionRelationConstraintsTests2 {

    @Test func first() throws {
        //<constraint firstItem="1Ti-GC-fQl" firstAttribute="leading" secondItem="oix-xr-OAB" secondAttribute="leading" id="3yc-Bi-b0W"/>
        let expected = "1Ti-GC-fQl.leadingAnchor.constraint(equalTo: oix-xr-OAB.leadingAnchor)"
        let result = try convertDimesionRelationConstraintsToCode(
            firstItem: "1Ti-GC-fQl",
            firstAttribute: "leading",
            relation: nil,
            secondItem: "oix-xr-OAB",
            secondItemAttribute: "leading",
            constant: nil,
            multiplier: nil,
            priority: nil,
            identifier: nil,
            id: "3yc-Bi-b0W"
        )
        #expect(result == expected)
    }
}

//
//  containerTypeDetectorTests.swift
//  story2code
//
//  Created by Blazej Sleboda on 17/07/2025.
//

import Testing
import Foundation
@testable import story2code

@MainActor
struct ContainerTypeDetectorTests {

    @Test func detectDimensionConstraint() throws {
        // <constraint firstAttribute="width" constant="60" id="P7Y-6I-8tL"/>
        let result = constraintTypeDetector(
            firstAttribute: "width",
            secondItem: nil,
            secondAttribute: nil,
            multiplier: "1:1",
        )
        #expect(result == .dimension)
    }

    @Test func dimensionWithRelation() throws {
        // <constraint firstAttribute="width" secondItem="psQ-hS-P6G" secondAttribute="height" multiplier="1:1" id="8NY-8c-J3A"/>
        let result = constraintTypeDetector(
            firstAttribute: "width",
            secondItem: "psQ-hS-P6G",
            secondAttribute: "height",
            multiplier: "1:1",
        )
        #expect(result == .dimensionRelation)
    }

    @Test func isAlignmentRelation() throws {
        // <constraint firstItem="1Ti-GC-fQl" firstAttribute="leading" secondItem="oix-xr-OAB" secondAttribute="leading" id="3yc-Bi-b0W"/>
        let result = constraintTypeDetector(
            firstAttribute: "leading",
            secondItem: "oix-xr-OAB",
            secondAttribute: "leading",
            multiplier: nil,
        )
        #expect(result == .alignmentRelation)
    }

    @Test func isAlignmentRelationWithMultiplier() throws {
        // <constraint firstItem="1Ti-GC-fQl" firstAttribute="leading" secondItem="oix-xr-OAB" secondAttribute="leading" id="3yc-Bi-b0W"/>
        let result = constraintTypeDetector(
            firstAttribute: "leading",
            secondItem: "oix-xr-OAB",
            secondAttribute: "leading",
            multiplier: "1",
        )
        #expect(result == .alignmentRelationWithMultiplier)
    }
}

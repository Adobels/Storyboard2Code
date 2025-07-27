//
//  AlignementConstraintsTests.swift
//  story2code
//
//  Created by Blazej Sleboda on 16/07/2025.
//

import Testing
import Foundation
import StoryboardDecoder
@testable import story2code


@Suite("Alignement Constraints Tests")
struct AlignementConstraintsTests {

    @Test func minimum() throws {
        //<constraint firstAttribute="leading" secondItem="WX4-pb-dXk" secondAttribute="trailing" id="G2F-Vi-Qre"/>
        let constraint = try convertAlignmentConstraintToCodeCore(
            firstItem: nil,
            firstAttribute: "leading",
            relation: nil,
            secondItem: "WX4-pb-dXk",
            secondAttribute: "trailing",
            constant: nil,
            multiplier: nil,
            priority: nil,
            identifier: nil
        )
        let expected = "$0.leadingAnchor.constraint(equalTo: WX4-pb-dXk.trailingAnchor)"
        #expect(constraint == expected)
    }

    @Test func testConvertConstraintToCode() throws {
        //<constraint firstItem="YE5-Pe-agX" firstAttribute="top" relation="greaterThanOrEqual" secondItem="WX4-pb-dXk" secondAttribute="bottom" priority="750" constant="54" id="G2F-Vi-Qre"/>
        let constraint = try convertAlignmentConstraintToCodeCore(
            firstItem: "YE5-Pe-agX",
            firstAttribute: "top",
            relation: "greaterThanOrEqual",
            secondItem: "WX4-pb-dXk",
            secondAttribute: "bottom",
            constant: 54,
            multiplier: nil,
            priority: 750,
            identifier: nil
        )
        let expected = #"YE5-Pe-agX.topAnchor.constraint(greaterThanOrEqualTo: WX4-pb-dXk.bottomAnchor, constant: 54).ibPriority(.defaultHigh)"#
        #expect(constraint == expected)
    }

    @Test func testConvertConstraintToCode2() throws {
        //<constraint firstItem="zIe-ud-T2u" firstAttribute="top" secondItem="pKi-7h-cVb" secondAttribute="top" id="2ry-gF-VPR"/>
        let constraint = try convertAlignmentConstraintToCodeCore(
            firstItem: "zIe-ud-T2u",
            firstAttribute: "top",
            relation: nil,
            secondItem: "pKi-7h-cVb",
            secondAttribute: "top",
            constant: nil,
            multiplier: nil,
            priority: nil,
            identifier: nil
        )
        let expected = "zIe-ud-T2u.topAnchor.constraint(equalTo: pKi-7h-cVb.topAnchor)"
        #expect(constraint == expected)
    }

    @Test func testConvertConstraintToCode3() throws {
        //<constraint firstItem="BCH-cq-un7" firstAttribute="leading" secondItem="1l3-KK-xG7" secondAttribute="leading" id="371-HH-qIs"/>
        let constraint = try convertAlignmentConstraintToCodeCore(
            firstItem: "BCH-cq-un7",
            firstAttribute: "leading",
            relation: nil,
            secondItem: "pKi-7h-cVb",
            secondAttribute: "leading",
            constant: nil,
            multiplier: nil,
            priority: nil,
            identifier: nil
        )
        let expected = "BCH-cq-un7.leadingAnchor.constraint(equalTo: pKi-7h-cVb.leadingAnchor)"
        #expect(constraint == expected)
    }

    @Test func testConvertConstraintToCode4() throws {
        //<constraint firstAttribute="bottom" secondItem="9qt-dK-HTf" secondAttribute="bottom" id="1y7-gW-0Xx"/>
        let constraint = try convertAlignmentConstraintToCodeCore(
            firstItem: nil,
            firstAttribute: "bottom",
            relation: nil,
            secondItem: "9qt-dK-HTf",
            secondAttribute: "bottom",
            constant: nil,
            multiplier: nil,
            priority: nil,
            identifier: nil
        )
        let expected = "$0.bottomAnchor.constraint(equalTo: 9qt-dK-HTf.bottomAnchor)"
        #expect(constraint == expected)
    }
}

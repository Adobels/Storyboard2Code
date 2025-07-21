//
//  DimensionConstraintsTests.swift
//  story2code
//
//  Created by Blazej Sleboda on 16/07/2025.
//

import Testing
import Foundation
import StoryboardDecoder
@testable import story2code

@MainActor
@Suite("Dimension Constraints Tests")
struct DimensionConstraintsTests {

    @Test() func testConvertPriorityToCode() throws {
        #expect(convertPriorityToCode(-1) == ".ibPriority(.init(-1))")
        #expect(convertPriorityToCode(0) == ".ibPriority(.init(0))")
        #expect(convertPriorityToCode(1) == ".ibPriority(.init(1))")
        #expect(convertPriorityToCode(1) == ".ibPriority(.init(1))")
        #expect(convertPriorityToCode(250) == ".ibPriority(.defaultLow)")
        #expect(convertPriorityToCode(750) == ".ibPriority(.defaultHigh)")
        #expect(convertPriorityToCode(1000) == ".ibPriority(.required)")
        #expect(convertPriorityToCode(1001) == ".ibPriority(.init(1001))")
        #expect(convertPriorityToCode(1002.1) == ".ibPriority(.init(1002))")
    }

    @Test() func testConstantArgument() throws {
        #expect(convertConstantToCode(-1000) == "constant: -1000")
        #expect(convertConstantToCode(-1) == "constant: -1")
        #expect(convertConstantToCode(0) == "constant: 0")
        #expect(convertConstantToCode(1) == "constant: 1")
        #expect(convertConstantToCode(1000) == "constant: 1000")
        #expect(convertConstantToCode(1000.1) == "constant: 1000.1")
        #expect(convertConstantToCode(1000.01) == "constant: 1000.01")
    }

    @Test() func testConvertMultiplierToCode() throws {
        #expect(convertMultiplierToCode("1:1") == "multiplier: 1")
        #expect(convertMultiplierToCode("300:190") == "multiplier: 1.5789474")
        #expect(convertMultiplierToCode("8:10") == "multiplier: 0.8")
        #expect(convertMultiplierToCode("3:2") == "multiplier: 1.5")
        #expect(convertMultiplierToCode("2:3") == "multiplier: 0.6666667")
        #expect(convertMultiplierToCode("0.77") == "multiplier: 0.77")
        #expect(convertMultiplierToCode("0.9") == "multiplier: 0.9")
        #expect(convertMultiplierToCode("1.65") == "multiplier: 1.65")
        #expect(convertMultiplierToCode("-1000") == "multiplier: -1000")
        #expect(convertMultiplierToCode("-1") == "multiplier: -1")
        #expect(convertMultiplierToCode("0") == "multiplier: 0")
        #expect(convertMultiplierToCode("1") == "multiplier: 1")
        #expect(convertMultiplierToCode("1000") == "multiplier: 1000")
        #expect(convertMultiplierToCode("1000.1") == "multiplier: 1000.1")
        #expect(convertMultiplierToCode("1000.01") == "multiplier: 1000.01")
    }

    @Test() func testConvertIdentifierToCode() throws {
        #expect(convertIdentifierToCode(nil) == nil)
        #expect(convertIdentifierToCode("") == nil)
        #expect(convertIdentifierToCode("heightConstraint") == #".ibIdentifier("heightConstraint")"#)
    }

    @Test func testConvertLayoutAttributeToAnchor() throws {
        #expect(convertLayoutAttributeToAnchor("top") == ".topAnchor")
        #expect(convertLayoutAttributeToAnchor("leading") == ".leadingAnchor")
        #expect(convertLayoutAttributeToAnchor("trailing") == ".trailingAnchor")
        #expect(convertLayoutAttributeToAnchor("bottom") == ".bottomAnchor")
        #expect(convertLayoutAttributeToAnchor("left") == ".leftAnchor")
        #expect(convertLayoutAttributeToAnchor("right") == ".rightAnchor")
        #expect(convertLayoutAttributeToAnchor("topMargin") == ".layoutMarginsGuide.topAnchor")
        #expect(convertLayoutAttributeToAnchor("leadingMargin") == ".layoutMarginsGuide.leadingAnchor")
        #expect(convertLayoutAttributeToAnchor("trailingMargin") == ".layoutMarginsGuide.trailingAnchor")
        #expect(convertLayoutAttributeToAnchor("rightMargin") == ".layoutMarginsGuide.rightAnchor")
        #expect(convertLayoutAttributeToAnchor("bottomMargin") == ".layoutMarginsGuide.bottomAnchor")
    }

    @Test func testConvertConstraintToCode() throws {
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
        let expected = #"ye_pe_agx.topAnchor.constraint(greaterThanOrEqualTo: wx_pb_dxk.bottomAnchor, constant: 54).ibPriority(.defaultHigh)"#
        #expect(constraint == expected)
        /*
         <constraint firstItem="YE5-Pe-agX" firstAttribute="top" relation="greaterThanOrEqual" secondItem="WX4-pb-dXk" secondAttribute="bottom" priority="750" constant="54" id="G2F-Vi-Qre"/>
         */
    }

    @Test func testConvertConstraintToCode2() throws {
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
        let expected = "zie_ud_tu.topAnchor.constraint(equalTo: pki_h_cvb.topAnchor)"
        #expect(constraint == expected)
        /*
         <constraint firstItem="zIe-ud-T2u" firstAttribute="top" secondItem="pKi-7h-cVb" secondAttribute="top" id="2ry-gF-VPR"/>
         */
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
        let expected = "bch_cq_un.leadingAnchor.constraint(equalTo: pki_h_cvb.leadingAnchor)"
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
        let expected = "$0.bottomAnchor.constraint(equalTo: qt_dk_htf.bottomAnchor)"
        #expect(constraint == expected)
    }

    @Test func testConvertConstraintToCode5() throws {
        //<constraint firstAttribute="height" constant="24" id="VAs-YE-m3q"/>
        let constraint = convertDimensionConstraintsToCode(
            firstAttribute: "height",
            relation: nil,
            constant: 24,
            priority: nil,
            identifier: nil,
            id: "VAs-YE-m3q"
        )
        let expected = "$0.heightAnchor.constraint(equalToConstant: 24)"
        #expect(constraint == expected)
    }

    @Test func testConvertConstraintToCode6() throws {
        let constraint = convertDimensionConstraintsToCode(
            firstAttribute: "width",
            relation: "greaterThanOrEqual",
            constant: -24.333,
            priority: 751,
            identifier: "heightConstraint",
            id: "VAs-YE-m3q"
        )
        let expected = #"$0.widthAnchor.constraint(greaterThanOrEqualToConstant: -24.333).ibPriority(.init(751)).ibIdentifier("heightConstraint")"#
        #expect(constraint == expected)
    }
}

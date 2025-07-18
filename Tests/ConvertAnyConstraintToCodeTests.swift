//
//  ConvertAnyConstraintToCodeTests.swift
//  story2code
//
//  Created by Blazej Sleboda on 17/07/2025.
//

import Testing
@testable import story2code

struct ConvertAnyConstraintToCodeTests {

    @Test func def() throws {
        // <constraint firstAttribute="height" constant="56" id="2rt-W3-C0q"/>
        let result = convertAnyConstraintToCode(
            firstItem: nil,
            firstAttribute: "height",
            relation: nil,
            secondItem: nil,
            secondAttribute: nil,
            constant: 56,
            multiplier: nil,
            priority: nil,
            identifier: nil,
            id: "2rt-W3-C0q"
        )
        #expect(result == "$0.heightAnchor.constraint(equalToConstant: 56)")
    }

    @Test func laf() throws {
        // <constraint firstAttribute="bottomMargin" secondItem="BIJ-TN-PgT" secondAttribute="bottom" constant="10" id="aPD-uo-gqU"/>
        let result = convertAnyConstraintToCode(
            firstItem: nil,
            firstAttribute: "bottomMargin",
            relation: nil,
            secondItem: "BIJ-TN-PgT",
            secondAttribute: "bottom",
            constant: 10,
            multiplier: nil,
            priority: nil,
            identifier: nil,
            id: "aPD-uo-gqU"
        )
        #expect(result == "$0.layoutMarginsGuide.bottomAnchor.constraint(equalTo: bij_tn_pgt.bottomAnchor, constant: 10)")
    }

    @Test func lkef() throws {
        // <constraint firstAttribute="bottomMargin" secondItem="BIJ-TN-PgT" secondAttribute="bottom" constant="10" id="aPD-uo-gqU"/>
        let result = convertAnyConstraintToCode(
            firstItem: nil,
            firstAttribute: "bottomMargin",
            relation: nil,
            secondItem: "BIJ-TN-PgT",
            secondAttribute: "bottom",
            constant: 10,
            multiplier: nil,
            priority: nil,
            identifier: nil,
            id: "aPD-uo-gqU"
        )
        #expect(result == "$0.layoutMarginsGuide.bottomAnchor.constraint(equalTo: bij_tn_pgt.bottomAnchor, constant: 10)")
    }

    @Test func ldede() throws {
        // <constraint firstItem="M0v-Fd-m0Q" firstAttribute="centerY" secondItem="vJe-wZ-L5E" secondAttribute="centerY" multiplier="1.1" constant="8" id="xfO-Xm-dz3"/>
        let result = convertAnyConstraintToCode(
            firstItem: "M0v-Fd-m0Q",
            firstAttribute: "centerY",
            relation: nil,
            secondItem: "vJe-wZ-L5E",
            secondAttribute: "centerY",
            constant: 8,
            multiplier: "1.1",
            priority: nil,
            identifier: nil,
            id: "xfO-Xm-dz3"
        )
        #expect(result == "NSLayoutConstraint(item: mv_fd_mq, attribute: .centerY, relatedBy: .equal, toItem: vJe-wZ-L5E, attribute: .centerY, multiplier: 1.1, constant: 8.0)")
    }
}

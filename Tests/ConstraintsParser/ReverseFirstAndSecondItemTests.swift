//
//  ReverseFirstAndSecondItemTests.swift
//  story2code
//
//  Created by Blazej Sleboda on 18/07/2025.
//

import Testing
@testable import story2code

struct ReverseFirstAndSecondItemTests {

    @Test func reverseFirstAndSecondItem() throws {
        var constraint: ParserConstraint = .init(
            firstItem: "rLT-p4-vqM",
            firstAttribute: "top",
            relation: nil,
            secondItem: "GMM-dW-Isy",
            secondAttribute: "bottom",
            multiplier: nil,
            priority: nil,
            constant: -20,
            identifier: nil,
            id: "ZLN-2t-t8Y"
        )
        constraint.reverseFirstAndSecondItem()
        let result = convertAnyConstraintToCode(
            firstItem: constraint.firstItem,
            firstAttribute: constraint.firstAttribute,
            relation: constraint.relation,
            secondItem: constraint.secondItem,
            secondAttribute: constraint.secondAttribute,
            constant: constraint.constant,
            multiplier: constraint.multiplier,
            priority: constraint.priority,
            identifier: constraint.identifier,
            id: constraint.id
        )
        let expected = "gmm_dw_isy.bottomAnchor.constraint(equalTo: rlt_p_vqm.topAnchor, constant: 20)"
        #expect(result == expected)
    }

    @Test func fzfer() throws {
        // <constraint firstAttribute="centerX" secondItem="JZU-ne-yTG" secondAttribute="centerX" multiplier="3:2" priority="222" constant="3" identifier="dede" id="t09-S0-LmM"/>


        // <constraint firstItem="JZU-ne-yTG" firstAttribute="centerX" secondItem="zDs-ce-bL8" secondAttribute="centerX" multiplier="2:3" priority="222" constant="-4.5" identifier="dede" id="t09-S0-LmM"/>

        var constraint: ParserConstraint = .init(
            firstItem: "zDs-ce-bL8",
            firstAttribute: "centerX",
            relation: nil,
            secondItem: "JZU-ne-yTG",
            secondAttribute: "centerX",
            multiplier: "3:2",
            priority: 222,
            constant: 3,
            identifier: "dede",
            id: "t09-S0-LmM"
        )
        constraint.reverseFirstAndSecondItem()
        let result = convertAnyConstraintToCode(
            firstItem: constraint.firstItem,
            firstAttribute: constraint.firstAttribute,
            relation: constraint.relation,
            secondItem: constraint.secondItem,
            secondAttribute: constraint.secondAttribute,
            constant: constraint.constant,
            multiplier: constraint.multiplier,
            priority: constraint.priority,
            identifier: constraint.identifier,
            id: constraint.id
        )
        let expected = #"NSLayoutConstraint(item: jzu_ne_ytg, attribute: .centerX, relatedBy: .equal, toItem: zDs-ce-bL8, attribute: .centerX, multiplier: 2:3, constant: -4.5).ibPriority(.init(222)).ibIdentifier("dede")"#
        #expect(result == expected)
    }
}

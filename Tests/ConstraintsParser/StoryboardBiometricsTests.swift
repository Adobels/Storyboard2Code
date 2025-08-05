//
//  StoryboardBiometricsTests.swift
//  story2code
//
//  Created by Blazej Sleboda on 18/07/2025.
//

import Testing
import Foundation
import StoryboardDecoder
@testable import story2code

@MainActor
struct StoryboardBiometricsTests {

    @Test func constraints() throws {
        let url = Bundle.module.url(forResource: "Biometrics", withExtension: "xml")!
        let sb = try StoryboardFile(url: url)
        guard let initialScene = sb.document.scenes?.first else { throw AppError.isNill }
        guard let viewController = initialScene.viewController else { throw AppError.isNill }
        guard let rootView = viewController.viewController.rootView as? View else { throw AppError.isNill }
        let ctx = try! Context(scene: initialScene)
        var result: [ConstraintInCode] = convertConstraintsToCode(rootView: rootView, ctx: ctx).reversed()
        let resultOrdered = {
            var tmp = [ConstraintInCode]()
            expected.forEach { expected in
                let first: ConstraintInCode = result.first { resultItem in resultItem.constraintId == expected.constraintId }!
                tmp.append(first)
            }
            return tmp
        }()
        result = resultOrdered
        #expect(result.count == expected.count)

        var found: [ConstraintInCode] = []
        var missing: [ConstraintInCode] = []
        result.enumerated().forEach { item in
            let isEqual: Bool = expected[item.offset] == item.element
            if isEqual {
                found.append(item.element)
            } else {
                missing.append(item.element)
                print("is: \(item.element.constraintId), \(item.element.viewId), \(item.element.code)")
                print("ex: \(expected[item.offset].constraintId), \(expected[item.offset].viewId), \(expected[item.offset].code)")
            }
        }
        print("FOUND (\(found.count)): ")
        found.forEach {
            print("\($0.constraintId), \($0.viewId), \($0.code)", separator: "\n")
        }

        print("MISSING (\(missing.count)): ")
        missing.forEach {
            print("\($0.constraintId), \($0.viewId), \($0.code)", separator: "\n")
        }
        #expect(missing.isEmpty)
    }

    @Test func def() throws {
        let url = Bundle.module.url(forResource: "Biometrics", withExtension: "xml")!
        let sb = try StoryboardFile(url: url)
        guard let initialScene = sb.document.scenes?.first else { throw AppError.isNill }
        guard let viewController = initialScene.viewController else { throw AppError.isNill }
        guard let rootView = viewController.viewController.rootView else { throw AppError.isNill }
        let hierarchy = generateHierarchyOfConstraintItemOwnersOf(rootView: rootView)
        let expected: [HierarchyElement] = [
            .init(eId: "PER-y7-qQK", vId: "PER-y7-qQK", lgKey: nil),
            .init(eId: "DnY-wV-ZhQ", vId: "PER-y7-qQK", lgKey: .safeArea),
            .init(eId: "Q9F-Uh-SHm", vId: "Q9F-Uh-SHm", lgKey: nil),
            .init(eId: "mQC-PI-eMm", vId: "mQC-PI-eMm", lgKey: nil),
            .init(eId: "JgL-1v-l7T", vId: "JgL-1v-l7T", lgKey: nil),
            .init(eId: "omo-0k-py9", vId: "omo-0k-py9", lgKey: nil),
            .init(eId: "M2X-Da-OBu", vId: "M2X-Da-OBu", lgKey: nil),
            .init(eId: "mE8-I2-iTF", vId: "mE8-I2-iTF", lgKey: nil),
            .init(eId: "cOz-oz-7WC", vId: "cOz-oz-7WC", lgKey: nil),
            .init(eId: "go4-XY-s4N", vId: "go4-XY-s4N", lgKey: nil),
            .init(eId: "Eny-iP-0M8", vId: "Eny-iP-0M8", lgKey: nil),
            .init(eId: "wzD-rD-jxu", vId: "wzD-rD-jxu", lgKey: nil),
            .init(eId: "OHi-Ag-V1y", vId: "OHi-Ag-V1y", lgKey: nil),
            .init(eId: "a0a-Uk-hPz", vId: "a0a-Uk-hPz", lgKey: nil),
        ]
        #expect(hierarchy == expected)
    }

    private let expected: [ConstraintInCode] = [
        .init(constraintId: "JAj-m8-VuO", viewId: "a0a-Uk-hPz", code: #"$0.topAnchor.constraint(equalTo: OHi-Ag-V1y.topAnchor)"#),
        .init(constraintId: "wZY-j4-ygi", viewId: "a0a-Uk-hPz", code: #"$0.bottomAnchor.constraint(equalTo: OHi-Ag-V1y.bottomAnchor)"#),
        .init(constraintId: "ck7-zr-Zuc", viewId: "a0a-Uk-hPz", code: #"$0.leadingAnchor.constraint(equalTo: OHi-Ag-V1y.leadingAnchor)"#),
        .init(constraintId: "el0-J1-Qx1", viewId: "a0a-Uk-hPz", code: #"$0.trailingAnchor.constraint(equalTo: OHi-Ag-V1y.trailingAnchor)"#),
        .init(constraintId: "9Yo-en-8O2", viewId: "wzD-rD-jxu", code: #"$0.topAnchor.constraint(equalTo: Eny-iP-0M8.topAnchor)"#),
        .init(constraintId: "kWd-mR-uJf", viewId: "wzD-rD-jxu", code: #"$0.bottomAnchor.constraint(equalTo: Eny-iP-0M8.bottomAnchor)"#),
        .init(constraintId: "sUV-DS-kWx", viewId: "wzD-rD-jxu", code: #"$0.leadingAnchor.constraint(equalTo: Eny-iP-0M8.leadingAnchor)"#),
        .init(constraintId: "uzW-Bl-viM", viewId: "wzD-rD-jxu", code: #"$0.trailingAnchor.constraint(equalTo: Eny-iP-0M8.trailingAnchor)"#),
        .init(constraintId: "HoM-Sg-2BW", viewId: "go4-XY-s4N", code: #"$0.topAnchor.constraint(equalTo: cOz-oz-7WC.topAnchor)"#),
        .init(constraintId: "Fnc-eh-aCS", viewId: "go4-XY-s4N", code: #"$0.bottomAnchor.constraint(equalTo: cOz-oz-7WC.bottomAnchor)"#),
        .init(constraintId: "P0g-o0-OYZ", viewId: "go4-XY-s4N", code: #"$0.leadingAnchor.constraint(equalTo: cOz-oz-7WC.leadingAnchor)"#),
        .init(constraintId: "bhD-9X-vn2", viewId: "go4-XY-s4N", code: #"$0.trailingAnchor.constraint(equalTo: cOz-oz-7WC.trailingAnchor)"#),
        .init(constraintId: "5X5-x7-3Td", viewId: "cOz-oz-7WC", code: #"$0.bottomAnchor.constraint(lessThanOrEqualTo: PER-y7-qQK.bottomAnchor, constant: -33)"#),
        .init(constraintId: "oaq-H4-TvR", viewId: "cOz-oz-7WC", code: #"$0.topAnchor.constraint(greaterThanOrEqualTo: JgL-1v-l7T.bottomAnchor, constant: 20)"#),
        .init(constraintId: "gga-Fm-cdz", viewId: "cOz-oz-7WC", code: #"$0.bottomAnchor.constraint(equalTo: PER-y7-qQK.safeAreaLayoutGuide.bottomAnchor, constant: 13).ibPriority(.defaultHigh)"#),
        .init(constraintId: "YMS-OG-r4O", viewId: "cOz-oz-7WC", code: #"$0.leadingAnchor.constraint(equalTo: PER-y7-qQK.safeAreaLayoutGuide.leadingAnchor, constant: 33)"#),
        .init(constraintId: "N6f-Zc-Pmv", viewId: "cOz-oz-7WC", code: #"$0.trailingAnchor.constraint(equalTo: PER-y7-qQK.safeAreaLayoutGuide.trailingAnchor, constant: -33)"#),
        .init(constraintId: "flO-bt-Nal", viewId: "mE8-I2-iTF", code: #"$0.topAnchor.constraint(equalTo: M2X-Da-OBu.bottomAnchor, constant: 15)"#),
        .init(constraintId: "c9f-ip-FeP", viewId: "mE8-I2-iTF", code: #"$0.bottomAnchor.constraint(equalTo: JgL-1v-l7T.bottomAnchor)"#),
        .init(constraintId: "HIC-nu-f3k", viewId: "mE8-I2-iTF", code: #"$0.leadingAnchor.constraint(equalTo: JgL-1v-l7T.leadingAnchor)"#),
        .init(constraintId: "rwb-gR-zEd", viewId: "mE8-I2-iTF", code: #"$0.trailingAnchor.constraint(equalTo: JgL-1v-l7T.trailingAnchor)"#),
        .init(constraintId: "Rxg-VU-fWy", viewId: "mE8-I2-iTF", code: #"$0.centerXAnchor.constraint(equalTo: JgL-1v-l7T.centerXAnchor)"#),
        .init(constraintId: "Jwo-wd-1Zm", viewId: "M2X-Da-OBu", code: #"$0.topAnchor.constraint(equalTo: omo-0k-py9.bottomAnchor, constant: 24)"#),
        .init(constraintId: "k2t-O8-Cyf", viewId: "M2X-Da-OBu", code: #"$0.leadingAnchor.constraint(equalTo: JgL-1v-l7T.leadingAnchor)"#),
        .init(constraintId: "a1f-a5-J3Z", viewId: "M2X-Da-OBu", code: #"$0.trailingAnchor.constraint(equalTo: JgL-1v-l7T.trailingAnchor)"#),
        .init(constraintId: "MLi-jY-msw", viewId: "M2X-Da-OBu", code: #"$0.centerXAnchor.constraint(equalTo: JgL-1v-l7T.centerXAnchor)"#),
        .init(constraintId: "xBr-PU-J84", viewId: "omo-0k-py9", code: #"$0.topAnchor.constraint(equalTo: JgL-1v-l7T.topAnchor)"#),
        .init(constraintId: "dri-Pm-1Kx", viewId: "omo-0k-py9", code: #"$0.centerXAnchor.constraint(equalTo: JgL-1v-l7T.centerXAnchor)"#),
        .init(constraintId: "lbd-a3-xW1", viewId: "JgL-1v-l7T", code: #"$0.topAnchor.constraint(greaterThanOrEqualTo: mQC-PI-eMm.bottomAnchor, constant: 20)"#),
        .init(constraintId: "cZZ-r4-Pbv", viewId: "JgL-1v-l7T", code: #"$0.leadingAnchor.constraint(equalTo: PER-y7-qQK.safeAreaLayoutGuide.leadingAnchor, constant: 44)"#),
        .init(constraintId: "9bo-zQ-JLb", viewId: "JgL-1v-l7T", code: #"$0.centerYAnchor.constraint(equalTo: PER-y7-qQK.centerYAnchor, constant: -50).ibPriority(.defaultLow)"#),
        .init(constraintId: "tw6-Ta-hEY", viewId: "JgL-1v-l7T", code: #"$0.trailingAnchor.constraint(equalTo: PER-y7-qQK.safeAreaLayoutGuide.trailingAnchor, constant: -44)"#),
        .init(constraintId: "3a3-o2-qAs", viewId: "mQC-PI-eMm", code: #"$0.topAnchor.constraint(equalTo: PER-y7-qQK.safeAreaLayoutGuide.topAnchor, constant: 34)"#),
        .init(constraintId: "azL-u6-fXZ", viewId: "mQC-PI-eMm", code: #"$0.leadingAnchor.constraint(equalTo: PER-y7-qQK.safeAreaLayoutGuide.leadingAnchor, constant: 33)"#),
        .init(constraintId: "Wuk-JQ-quH", viewId: "Q9F-Uh-SHm", code: #"$0.topAnchor.constraint(equalTo: PER-y7-qQK.topAnchor)"#),
        .init(constraintId: "yeO-9X-8xR", viewId: "Q9F-Uh-SHm", code: #"$0.bottomAnchor.constraint(equalTo: PER-y7-qQK.bottomAnchor)"#),
        .init(constraintId: "p6m-3V-qV9", viewId: "Q9F-Uh-SHm", code: #"$0.leadingAnchor.constraint(equalTo: PER-y7-qQK.leadingAnchor)"#),
        .init(constraintId: "Vs7-GQ-lJ7", viewId: "Q9F-Uh-SHm", code: #"$0.trailingAnchor.constraint(equalTo: PER-y7-qQK.trailingAnchor)"#),
    ]
}

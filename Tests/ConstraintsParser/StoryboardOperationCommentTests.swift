//
//  StoryboardOperationCommentTests.swift
//  story2code
//
//  Created by Blazej Sleboda on 18/07/2025.
//

import Testing
import Foundation
import StoryboardDecoder
@testable import story2code

@MainActor
struct StoryboardOperationCommentTests {

    private let resource = "OperationComment"

    @Test func constraints() throws {
        let url = Bundle.module.url(forResource: resource, withExtension: "xml")!
        let sb = try StoryboardFile(url: url)
        guard let initialScene = sb.document.scenes?.first else { throw AppError.isNill }
        guard let viewController = initialScene.viewController else { throw AppError.isNill }
        guard let rootView = viewController.viewController.rootView as? View else { throw AppError.isNill }
        var result: [ConstraintInCode] = convertConstraintsToCode(rootView: rootView).reversed()
        result.forEach {
            print(".init(constraintId: \"\($0.constraintId)\", viewId: \"\($0.viewId)\", code: \"\($0.code)\"),")
        }
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
        var different: [ConstraintInCode] = []
        result.enumerated().forEach { item in
            let isEqual: Bool = expected[item.offset] == item.element
            if isEqual {
                found.append(item.element)
            } else {
                different.append(item.element)
                print("is: \(item.element.constraintId), \(item.element.viewId), \(item.element.code)")
                print("ex: \(expected[item.offset].constraintId), \(expected[item.offset].viewId), \(expected[item.offset].code)")
            }
        }
        print("EQUAL (\(found.count)): ")
        found.forEach {
            print("\($0.constraintId), \($0.viewId), \($0.code)", separator: "\n")
        }

        print("IS_DIFFERENT (\(different.count)): ")
        different.forEach {
            print("\($0.constraintId), \($0.viewId), \($0.code)", separator: "\n")
        }
        #expect(different.isEmpty == true)
    }

    @Test func def() throws {
        let url = Bundle.module.url(forResource: resource, withExtension: "xml")!
        let sb = try StoryboardFile(url: url)
        guard let initialScene = sb.document.scenes?.first else { throw AppError.isNill }
        guard let viewController = initialScene.viewController else { throw AppError.isNill }
        guard let rootView = viewController.viewController.rootView else { throw AppError.isNill }
        let hierarchy = generateHierarchyOfConstraintItemOwnersOf(rootView: rootView)
        let expected: [HierarchyElement] = [
            .init(eId: "9b3-dl-D0C", vId: "9b3-dl-D0C", lgKey: nil),
            .init(eId: "ObT-7D-45W", vId: "9b3-dl-D0C", lgKey: .safeArea),
            .init(eId: "mrj-Ra-OQS", vId: "9b3-dl-D0C", lgKey: .keyboard),
            .init(eId: "8uM-Vj-wPL", vId: "8uM-Vj-wPL", lgKey: nil),
            .init(eId: "5gV-4i-pQj", vId: "5gV-4i-pQj", lgKey: nil),
            .init(eId: "uWu-eE-Dpw", vId: "uWu-eE-Dpw", lgKey: nil),
            .init(eId: "UkI-Vl-3P1", vId: "UkI-Vl-3P1", lgKey: nil),
            .init(eId: "NNz-Oq-7TY", vId: "NNz-Oq-7TY", lgKey: nil),
            .init(eId: "EUj-Lg-FS5", vId: "EUj-Lg-FS5", lgKey: nil),
            .init(eId: "N6e-qt-99J", vId: "N6e-qt-99J", lgKey: nil),
            .init(eId: "p90-Ed-fOn", vId: "p90-Ed-fOn", lgKey: nil)
        ]
        #expect(hierarchy == expected)
    }

    private let expected: [ConstraintInCode] = [
        .init(constraintId: "AcO-Y3-5DE", viewId: "8uM-Vj-wPL", code: "$0.topAnchor.constraint(equalTo: 9b3-dl-D0C.topAnchor)"),
        .init(constraintId: "Lf8-mc-p7R", viewId: "8uM-Vj-wPL", code: "$0.leadingAnchor.constraint(equalTo: 9b3-dl-D0C.safeAreaLayoutGuide.leadingAnchor)"),
        .init(constraintId: "tJm-SF-5hC", viewId: "8uM-Vj-wPL", code: "$0.trailingAnchor.constraint(equalTo: 9b3-dl-D0C.safeAreaLayoutGuide.trailingAnchor)"),
        .init(constraintId: "tjV-sh-SMB", viewId: "8uM-Vj-wPL", code: "$0.heightAnchor.constraint(greaterThanOrEqualToConstant: 76)"),
        .init(constraintId: "J24-6h-o2O", viewId: "5gV-4i-pQj", code: "$0.leadingAnchor.constraint(equalTo: 8uM-Vj-wPL.leadingAnchor)"),
        .init(constraintId: "qEP-KI-hFA", viewId: "5gV-4i-pQj", code: "$0.topAnchor.constraint(equalTo: 8uM-Vj-wPL.layoutMarginsGuide.topAnchor).ibPriority(.defaultHigh)"),
        .init(constraintId: "k2A-D3-pCr", viewId: "5gV-4i-pQj", code: "$0.topAnchor.constraint(greaterThanOrEqualTo: 8uM-Vj-wPL.topAnchor, constant: 20)"),
        .init(constraintId: "EX7-Ji-cCM", viewId: "5gV-4i-pQj", code: "$0.widthAnchor.constraint(equalToConstant: 60)"),
        .init(constraintId: "HgH-PY-HUg", viewId: "5gV-4i-pQj", code: "$0.heightAnchor.constraint(equalToConstant: 56)"),
        .init(constraintId: "HBN-eC-yRo", viewId: "uWu-eE-Dpw", code: "$0.centerXAnchor.constraint(equalTo: 8uM-Vj-wPL.centerXAnchor)"),
        .init(constraintId: "hM5-0O-6cA", viewId: "uWu-eE-Dpw", code: "$0.bottomAnchor.constraint(equalTo: 8uM-Vj-wPL.bottomAnchor, constant: -20)"),
        .init(constraintId: "8dH-ua-q1z", viewId: "uWu-eE-Dpw", code: "$0.centerYAnchor.constraint(equalTo: 5gV-4i-pQj.centerYAnchor)"),
        .init(constraintId: "ERw-rb-wre", viewId: "UkI-Vl-3P1", code: "$0.trailingAnchor.constraint(equalTo: 8uM-Vj-wPL.trailingAnchor, constant: -6)"),
        .init(constraintId: "F6c-if-m3H", viewId: "UkI-Vl-3P1", code: "$0.bottomAnchor.constraint(equalTo: 8uM-Vj-wPL.bottomAnchor)"),
        .init(constraintId: "0UT-ay-C63", viewId: "UkI-Vl-3P1", code: "$0.centerYAnchor.constraint(equalTo: 5gV-4i-pQj.centerYAnchor)"),
        .init(constraintId: "x3c-7F-mCT", viewId: "UkI-Vl-3P1", code: "$0.widthAnchor.constraint(equalToConstant: 80)"),
        .init(constraintId: "h1C-Hb-3jF", viewId: "UkI-Vl-3P1", code: "$0.heightAnchor.constraint(equalToConstant: 56)"),
        .init(constraintId: "Bw9-kf-H4a", viewId: "NNz-Oq-7TY", code: "$0.widthAnchor.constraint(equalTo: NNz-Oq-7TY.heightAnchor, multiplier: 1)"),
        .init(constraintId: "kav-u5-9jm", viewId: "NNz-Oq-7TY", code: "$0.trailingAnchor.constraint(equalTo: 8uM-Vj-wPL.trailingAnchor, constant: -5)"),
        .init(constraintId: "rRk-kB-wrE", viewId: "NNz-Oq-7TY", code: "$0.bottomAnchor.constraint(equalTo: 8uM-Vj-wPL.bottomAnchor)"),
        .init(constraintId: "Ac6-k5-A9S", viewId: "NNz-Oq-7TY", code: "$0.topAnchor.constraint(equalTo: 8uM-Vj-wPL.layoutMarginsGuide.topAnchor)"),
        .init(constraintId: "NdG-kX-2ad", viewId: "EUj-Lg-FS5", code: "$0.trailingAnchor.constraint(equalTo: 9b3-dl-D0C.safeAreaLayoutGuide.trailingAnchor, constant: -20)"),
        .init(constraintId: "rch-OO-d3O", viewId: "EUj-Lg-FS5", code: "$0.bottomAnchor.constraint(equalTo: 9b3-dl-D0C.keyboardLayoutGuide.topAnchor)"),
        .init(constraintId: "cZz-ui-7en", viewId: "EUj-Lg-FS5", code: "$0.leadingAnchor.constraint(equalTo: 9b3-dl-D0C.safeAreaLayoutGuide.leadingAnchor, constant: 20)"),
        .init(constraintId: "X62-So-bky", viewId: "EUj-Lg-FS5", code: "$0.topAnchor.constraint(equalTo: 8uM-Vj-wPL.bottomAnchor)"),
        .init(constraintId: "5Am-E2-P4q", viewId: "N6e-qt-99J", code: "$0.trailingAnchor.constraint(equalTo: EUj-Lg-FS5.trailingAnchor)"),
        .init(constraintId: "LuM-2n-5hV", viewId: "N6e-qt-99J", code: "$0.leadingAnchor.constraint(equalTo: EUj-Lg-FS5.leadingAnchor)"),
        .init(constraintId: "Cbr-EX-iYS", viewId: "N6e-qt-99J", code: "$0.bottomAnchor.constraint(equalTo: EUj-Lg-FS5.bottomAnchor)"),
        .init(constraintId: "MrX-CF-QDJ", viewId: "N6e-qt-99J", code: "$0.topAnchor.constraint(equalTo: EUj-Lg-FS5.topAnchor)"),
        .init(constraintId: "o8k-7n-GDE", viewId: "p90-Ed-fOn", code: "$0.trailingAnchor.constraint(equalTo: EUj-Lg-FS5.trailingAnchor)"),
        .init(constraintId: "j6A-xW-aJT", viewId: "p90-Ed-fOn", code: "$0.leadingAnchor.constraint(equalTo: EUj-Lg-FS5.leadingAnchor)"),
        .init(constraintId: "adb-NX-kYK", viewId: "p90-Ed-fOn", code: "$0.bottomAnchor.constraint(equalTo: EUj-Lg-FS5.bottomAnchor)"),
        .init(constraintId: "lTB-1h-oCj", viewId: "p90-Ed-fOn", code: "$0.topAnchor.constraint(equalTo: EUj-Lg-FS5.topAnchor)"),
    ]
}

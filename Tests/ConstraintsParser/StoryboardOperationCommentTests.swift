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
            .init(eId: "baK-Su-87H", vId: "baK-Su-87H", lgKey: nil),
            .init(eId: "e8i-wu-Xcu", vId: "baK-Su-87H", lgKey: .safeArea),
            .init(eId: "eo3-u4-K6S", vId: "eo3-u4-K6S", lgKey: nil),
            .init(eId: "rLT-p4-vqM", vId: "rLT-p4-vqM", lgKey: nil),
            .init(eId: "Th6-o1-fRg", vId: "Th6-o1-fRg", lgKey: nil),
            .init(eId: "W4l-pd-zxI", vId: "W4l-pd-zxI", lgKey: nil),
            .init(eId: "gpW-lH-thK", vId: "gpW-lH-thK", lgKey: nil),
            .init(eId: "XN7-gt-jHw", vId: "XN7-gt-jHw", lgKey: nil),
            .init(eId: "iS7-gJ-v3f", vId: "iS7-gJ-v3f", lgKey: nil),
            .init(eId: "YH4-TE-dSf", vId: "YH4-TE-dSf", lgKey: nil),
            .init(eId: "0U7-o5-kKu", vId: "0U7-o5-kKu", lgKey: nil),
            .init(eId: "EYg-Tt-zDJ", vId: "EYg-Tt-zDJ", lgKey: nil),
            .init(eId: "ek5-ql-irC", vId: "ek5-ql-irC", lgKey: nil),
            .init(eId: "PxC-7S-Zhx", vId: "PxC-7S-Zhx", lgKey: nil),
            .init(eId: "43F-SP-LT6", vId: "43F-SP-LT6", lgKey: nil),
            .init(eId: "aJi-IT-j9R", vId: "aJi-IT-j9R", lgKey: nil),
            .init(eId: "vkN-PV-1Ub", vId: "vkN-PV-1Ub", lgKey: nil),
            .init(eId: "5uA-AJ-mG0", vId: "5uA-AJ-mG0", lgKey: nil),
            .init(eId: "1Wf-Jg-gOa", vId: "1Wf-Jg-gOa", lgKey: nil),
        ]
        #expect(hierarchy == expected)
    }

    private let expected: [ConstraintInCode] = [
        .init(constraintId: "AcO-Y3-5DE", viewId: "um_vj_wpl", code: "$0.topAnchor.constraint(equalTo: b_dl_dc.topAnchor)"),
        .init(constraintId: "Lf8-mc-p7R", viewId: "um_vj_wpl", code: "$0.leadingAnchor.constraint(equalTo: b_dl_dc.safeAreaLayoutGuide.leadingAnchor)"),
        .init(constraintId: "tJm-SF-5hC", viewId: "um_vj_wpl", code: "$0.trailingAnchor.constraint(equalTo: b_dl_dc.safeAreaLayoutGuide.trailingAnchor)"),
        .init(constraintId: "tjV-sh-SMB", viewId: "um_vj_wpl", code: "$0.heightAnchor.constraint(greaterThanOrEqualToConstant: 76)"),
        .init(constraintId: "J24-6h-o2O", viewId: "gv_i_pqj", code: "$0.leadingAnchor.constraint(equalTo: um_vj_wpl.leadingAnchor)"),
        .init(constraintId: "qEP-KI-hFA", viewId: "gv_i_pqj", code: "$0.topAnchor.constraint(equalTo: um_vj_wpl.layoutMarginsGuide.topAnchor).ibPriority(.defaultHigh)"),
        .init(constraintId: "k2A-D3-pCr", viewId: "gv_i_pqj", code: "$0.topAnchor.constraint(greaterThanOrEqualTo: um_vj_wpl.topAnchor, constant: 20)"),
        .init(constraintId: "EX7-Ji-cCM", viewId: "gv_i_pqj", code: "$0.widthAnchor.constraint(equalToConstant: 60)"),
        .init(constraintId: "HgH-PY-HUg", viewId: "gv_i_pqj", code: "$0.heightAnchor.constraint(equalToConstant: 56)"),
        .init(constraintId: "HBN-eC-yRo", viewId: "uwu_ee_dpw", code: "$0.centerXAnchor.constraint(equalTo: um_vj_wpl.centerXAnchor)"),
        .init(constraintId: "hM5-0O-6cA", viewId: "uwu_ee_dpw", code: "$0.bottomAnchor.constraint(equalTo: um_vj_wpl.bottomAnchor, constant: -20)"),
        .init(constraintId: "8dH-ua-q1z", viewId: "uwu_ee_dpw", code: "$0.centerYAnchor.constraint(equalTo: gv_i_pqj.centerYAnchor)"),
        .init(constraintId: "ERw-rb-wre", viewId: "uki_vl_p", code: "$0.trailingAnchor.constraint(equalTo: um_vj_wpl.trailingAnchor, constant: -6)"),
        .init(constraintId: "F6c-if-m3H", viewId: "uki_vl_p", code: "$0.bottomAnchor.constraint(equalTo: um_vj_wpl.bottomAnchor)"),
        .init(constraintId: "0UT-ay-C63", viewId: "uki_vl_p", code: "$0.centerYAnchor.constraint(equalTo: gv_i_pqj.centerYAnchor)"),
        .init(constraintId: "x3c-7F-mCT", viewId: "uki_vl_p", code: "$0.widthAnchor.constraint(equalToConstant: 80)"),
        .init(constraintId: "h1C-Hb-3jF", viewId: "uki_vl_p", code: "$0.heightAnchor.constraint(equalToConstant: 56)"),
        .init(constraintId: "Bw9-kf-H4a", viewId: "nnz_oq_ty", code: "$0.widthAnchor.constraint(equalTo: nnz_oq_ty.heightAnchor, multiplier: 1)"),
        .init(constraintId: "kav-u5-9jm", viewId: "nnz_oq_ty", code: "$0.trailingAnchor.constraint(equalTo: um_vj_wpl.trailingAnchor, constant: -5)"),
        .init(constraintId: "rRk-kB-wrE", viewId: "nnz_oq_ty", code: "$0.bottomAnchor.constraint(equalTo: um_vj_wpl.bottomAnchor)"),
        .init(constraintId: "Ac6-k5-A9S", viewId: "nnz_oq_ty", code: "$0.topAnchor.constraint(equalTo: um_vj_wpl.layoutMarginsGuide.topAnchor)"),
        .init(constraintId: "NdG-kX-2ad", viewId: "euj_lg_fs", code: "$0.trailingAnchor.constraint(equalTo: b_dl_dc.safeAreaLayoutGuide.trailingAnchor, constant: -20)"),
        .init(constraintId: "rch-OO-d3O", viewId: "euj_lg_fs", code: "$0.bottomAnchor.constraint(equalTo: b_dl_dc.keyboardLayoutGuide.topAnchor)"),
        .init(constraintId: "cZz-ui-7en", viewId: "euj_lg_fs", code: "$0.leadingAnchor.constraint(equalTo: b_dl_dc.safeAreaLayoutGuide.leadingAnchor, constant: 20)"),
        .init(constraintId: "X62-So-bky", viewId: "euj_lg_fs", code: "$0.topAnchor.constraint(equalTo: um_vj_wpl.bottomAnchor)"),
        .init(constraintId: "5Am-E2-P4q", viewId: "ne_qt_j", code: "$0.trailingAnchor.constraint(equalTo: euj_lg_fs.trailingAnchor)"),
        .init(constraintId: "LuM-2n-5hV", viewId: "ne_qt_j", code: "$0.leadingAnchor.constraint(equalTo: euj_lg_fs.leadingAnchor)"),
        .init(constraintId: "Cbr-EX-iYS", viewId: "ne_qt_j", code: "$0.bottomAnchor.constraint(equalTo: euj_lg_fs.bottomAnchor)"),
        .init(constraintId: "MrX-CF-QDJ", viewId: "ne_qt_j", code: "$0.topAnchor.constraint(equalTo: euj_lg_fs.topAnchor)"),
        .init(constraintId: "o8k-7n-GDE", viewId: "p_ed_fon", code: "$0.trailingAnchor.constraint(equalTo: euj_lg_fs.trailingAnchor)"),
        .init(constraintId: "j6A-xW-aJT", viewId: "p_ed_fon", code: "$0.leadingAnchor.constraint(equalTo: euj_lg_fs.leadingAnchor)"),
        .init(constraintId: "adb-NX-kYK", viewId: "p_ed_fon", code: "$0.bottomAnchor.constraint(equalTo: euj_lg_fs.bottomAnchor)"),
        .init(constraintId: "lTB-1h-oCj", viewId: "p_ed_fon", code: "$0.topAnchor.constraint(equalTo: euj_lg_fs.topAnchor)"),
    ]
}

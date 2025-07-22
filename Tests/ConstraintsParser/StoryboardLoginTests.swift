//
//  StoryboardLoginTests.swift
//  story2code
//
//  Created by Blazej Sleboda on 18/07/2025.
//

import Testing
import Foundation
import StoryboardDecoder
@testable import story2code

struct StoryboardLoginTests {

    @Test func constraints() throws {
        let url = Bundle.module.url(forResource: "Login", withExtension: "xml")!
        let sb = try StoryboardFile(url: url)
        guard let initialScene = sb.document.scenes?.first else { throw AppError.isNill }
        guard let viewController = initialScene.viewController else { throw AppError.isNill }
        guard let rootView = viewController.viewController.rootView as? View else { throw AppError.isNill }
        var result: [ConstraintInCode] = convertConstraintsToCode(rootView: rootView).reversed()
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

    @Test func actions() throws {
        let url = Bundle.module.url(forResource: "Login", withExtension: "xml")!
        let sb = try StoryboardFile(url: url)
        guard let initialScene = sb.document.scenes?.first else { throw AppError.isNill }
        let results = extractActions(of: initialScene)
        let expectedResults: [ExtractedAction] = [
            .init(actionId: "apr-73-iAm", ownerId: "ek5-ql-irC", code: "$0.addTarget(self, action: #selector(didTapIdentifierClearButton, for: .touchUpInside)"),
            .init(actionId: "piM-N8-QFT", ownerId: "aJi-IT-j9R", code: "$0.addTarget(self, action: #selector(didTapPasswordButton, for: .touchUpInside)"),
            .init(actionId: "ctX-CB-SMJ", ownerId: "vkN-PV-1Ub", code: "$0.addTarget(self, action: #selector(login(_:), for: .touchUpInside)"),
            .init(actionId: "iSO-Sl-8ys", ownerId: "1Wf-Jg-gOa", code: "$0.addTarget(self, action: #selector(biometrics(_:), for: .touchUpInside)"),
            .init(actionId: "P10-Sh-wge", ownerId: "kVf-kS-YQ3", code: "$0.addTarget(self, action: #selector(dismissKeyboard(gesture:))")
        ]
        #expect(results.count == expectedResults.count)
        expectedResults.enumerated().forEach { exptectedResult in
            #expect(exptectedResult.element == results[exptectedResult.offset])
        }
    }

    @Test func def() throws {
        let url = Bundle.module.url(forResource: "Login", withExtension: "xml")!
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
        .init(constraintId: "Kzp-3r-Tnb", viewId: "eo_u_ks", code: "$0.bottomAnchor.constraint(equalTo: bak_su_h.bottomAnchor)"),
        .init(constraintId: "ff8-JT-ZyT", viewId: "eo_u_ks", code: "$0.topAnchor.constraint(equalTo: bak_su_h.topAnchor)"),
        .init(constraintId: "wiF-pi-7eO", viewId: "eo_u_ks", code: "$0.trailingAnchor.constraint(equalTo: bak_su_h.safeAreaLayoutGuide.trailingAnchor)"),
        .init(constraintId: "N0b-8V-8So", viewId: "eo_u_ks", code: "$0.leadingAnchor.constraint(equalTo: bak_su_h.safeAreaLayoutGuide.leadingAnchor)"),
        .init(constraintId: "m6b-R0-hAT", viewId: "rlt_p_vqm", code: "$0.trailingAnchor.constraint(equalTo: bak_su_h.safeAreaLayoutGuide.trailingAnchor)"),
        .init(constraintId: "dNa-6s-1D2", viewId: "rlt_p_vqm", code: "$0.leadingAnchor.constraint(equalTo: bak_su_h.safeAreaLayoutGuide.leadingAnchor)"),
        .init(constraintId: "ZLN-2t-t8Y", viewId: "rlt_p_vqm", code: "$0.topAnchor.constraint(equalTo: bak_su_h.safeAreaLayoutGuide.topAnchor)"),
        .init(constraintId: "qar-hB-RMS", viewId: "th_o_frg", code: "$0.centerXAnchor.constraint(equalTo: rlt_p_vqm.centerXAnchor)"),
        .init(constraintId: "M0W-DR-OVN", viewId: "th_o_frg", code: "$0.centerYAnchor.constraint(equalTo: rlt_p_vqm.centerYAnchor).ibPriority(.defaultHigh)"),
        .init(constraintId: "6Lq-qL-0lz", viewId: "th_o_frg", code: "$0.bottomAnchor.constraint(lessThanOrEqualTo: rlt_p_vqm.bottomAnchor, constant: -10)"),
        .init(constraintId: "kYz-Gw-vwl", viewId: "th_o_frg", code: "$0.topAnchor.constraint(greaterThanOrEqualTo: rlt_p_vqm.topAnchor, constant: 20)"),
        .init(constraintId: "VP1-EE-53O", viewId: "wl_pd_zxi", code: "$0.leadingAnchor.constraint(equalTo: rlt_p_vqm.leadingAnchor, constant: 33)"),
        .init(constraintId: "rhI-pp-Jon", viewId: "wl_pd_zxi", code: "$0.bottomAnchor.constraint(lessThanOrEqualTo: rlt_p_vqm.bottomAnchor, constant: -16)"),
        .init(constraintId: "JDa-lt-4Af", viewId: "wl_pd_zxi", code: "$0.topAnchor.constraint(equalTo: rlt_p_vqm.topAnchor, constant: 34)"),
        .init(constraintId: "gMH-aP-ooO", viewId: "gpw_lh_thk", code: "$0.bottomAnchor.constraint(lessThanOrEqualTo: bak_su_h.safeAreaLayoutGuide.bottomAnchor)"),
        .init(constraintId: "lMJ-jk-4N4", viewId: "gpw_lh_thk", code: "$0.centerXAnchor.constraint(equalTo: bak_su_h.centerXAnchor)"),
        .init(constraintId: "wHp-Up-hRQ", viewId: "gpw_lh_thk", code: "$0.centerYAnchor.constraint(equalTo: bak_su_h.centerYAnchor, constant: -40).ibPriority(.init(500))"),
        .init(constraintId: "uES-gS-m9z", viewId: "gpw_lh_thk", code: #"$0.widthAnchor.constraint(equalTo: bak_su_h.widthAnchor, multiplier: 0.81)"#),
        .init(constraintId: "YNx-bN-Hy5", viewId: "gpw_lh_thk", code: "$0.topAnchor.constraint(equalTo: rlt_p_vqm.bottomAnchor)"),
        .init(constraintId: "QcP-JM-ovN", viewId: "xn_gt_jhw", code: "$0.trailingAnchor.constraint(equalTo: gpw_lh_thk.trailingAnchor)"),
        .init(constraintId: "hJk-6F-09W", viewId: "xn_gt_jhw", code: "$0.leadingAnchor.constraint(equalTo: gpw_lh_thk.leadingAnchor)"),
        .init(constraintId: "Bsa-6r-u7Q", viewId: "xn_gt_jhw", code: "$0.topAnchor.constraint(equalTo: gpw_lh_thk.topAnchor)"),
        .init(constraintId: "MME-LI-81G", viewId: "is_gj_vf", code: "$0.trailingAnchor.constraint(equalTo: gpw_lh_thk.trailingAnchor)"),
        .init(constraintId: "aiW-Dp-wbV", viewId: "is_gj_vf", code: "$0.leadingAnchor.constraint(equalTo: gpw_lh_thk.leadingAnchor)"),
        .init(constraintId: "XNH-P9-lAS", viewId: "is_gj_vf", code: "$0.topAnchor.constraint(equalTo: xn_gt_jhw.bottomAnchor, constant: 26).ibPriority(.defaultLow)"),
        .init(constraintId: "ful-HK-GTn", viewId: "is_gj_vf", code: "$0.topAnchor.constraint(greaterThanOrEqualTo: xn_gt_jhw.bottomAnchor, constant: 16)"),
        .init(constraintId: "Ruq-9T-E9D", viewId: "is_gj_vf", code: "$0.heightAnchor.constraint(equalToConstant: 120)"),
        .init(constraintId: "tQQ-sF-Rmb", viewId: "yh_te_dsf", code: "$0.trailingAnchor.constraint(equalTo: is_gj_vf.trailingAnchor)"),
        .init(constraintId: "nfj-4t-1lx", viewId: "yh_te_dsf", code: "$0.leadingAnchor.constraint(equalTo: is_gj_vf.leadingAnchor)"),
        .init(constraintId: "O8V-rW-hrv", viewId: "yh_te_dsf", code: "$0.topAnchor.constraint(equalTo: is_gj_vf.topAnchor)"),
        .init(constraintId: "1Qt-aM-kno", viewId: "yh_te_dsf", code: "$0.heightAnchor.constraint(equalToConstant: 60)"),
        .init(constraintId: "DuT-U9-asn", viewId: "u_o_kku", code: "$0.trailingAnchor.constraint(equalTo: yh_te_dsf.trailingAnchor)"),
        .init(constraintId: "CNj-Yc-JHO", viewId: "u_o_kku", code: "$0.leadingAnchor.constraint(equalTo: yh_te_dsf.leadingAnchor)"),
        .init(constraintId: "Ii5-Jr-Hpy", viewId: "u_o_kku", code: "$0.bottomAnchor.constraint(equalTo: yh_te_dsf.bottomAnchor)"),
        .init(constraintId: "duE-Hf-4UY", viewId: "u_o_kku", code: "$0.topAnchor.constraint(equalTo: yh_te_dsf.topAnchor)"),
        .init(constraintId: "Wj0-CX-cbk", viewId: "eyg_tt_zdj", code: "$0.centerYAnchor.constraint(equalTo: u_o_kku.centerYAnchor)"),
        .init(constraintId: "wqx-cO-Jjs", viewId: "eyg_tt_zdj", code: "$0.leadingAnchor.constraint(equalTo: u_o_kku.leadingAnchor, constant: 18)"),
        .init(constraintId: "2IB-Nd-Y8U", viewId: "ek_ql_irc", code: "$0.trailingAnchor.constraint(equalTo: u_o_kku.trailingAnchor)"),
        .init(constraintId: "QY1-7L-Qmw", viewId: "ek_ql_irc", code: "$0.bottomAnchor.constraint(equalTo: u_o_kku.bottomAnchor)"),
        .init(constraintId: "gcK-fd-2Kj", viewId: "ek_ql_irc", code: "$0.topAnchor.constraint(equalTo: u_o_kku.topAnchor)"),
        .init(constraintId: "mcC-4F-l0f", viewId: "ek_ql_irc", code: "$0.leadingAnchor.constraint(equalTo: eyg_tt_zdj.trailingAnchor)"),
        .init(constraintId: "eYV-jJ-yAe", viewId: "ek_ql_irc", code: "$0.widthAnchor.constraint(equalToConstant: 50)"),
        .init(constraintId: "JOT-se-4yM", viewId: "pxc_s_zhx", code: "$0.trailingAnchor.constraint(equalTo: is_gj_vf.trailingAnchor)"),
        .init(constraintId: "TA9-5f-WeM", viewId: "pxc_s_zhx", code: "$0.leadingAnchor.constraint(equalTo: is_gj_vf.leadingAnchor)"),
        .init(constraintId: "XWn-ux-cJ1", viewId: "pxc_s_zhx", code: "$0.bottomAnchor.constraint(equalTo: is_gj_vf.bottomAnchor)"),
        .init(constraintId: "ZFX-2Y-nZ3", viewId: "pxc_s_zhx", code: "$0.topAnchor.constraint(equalTo: yh_te_dsf.bottomAnchor)"),
        .init(constraintId: "KUx-lF-Tef", viewId: "pxc_s_zhx", code: "$0.heightAnchor.constraint(equalToConstant: 60)"),
        .init(constraintId: "2yM-cS-I7I", viewId: "f_sp_lt", code: "$0.trailingAnchor.constraint(equalTo: is_gj_vf.trailingAnchor)"),
        .init(constraintId: "tKy-bi-jZM", viewId: "f_sp_lt", code: "$0.leadingAnchor.constraint(equalTo: is_gj_vf.leadingAnchor)"),
        .init(constraintId: "yia-w1-q66", viewId: "f_sp_lt", code: "$0.topAnchor.constraint(equalTo: yh_te_dsf.bottomAnchor)"),
        .init(constraintId: "Fty-Yl-5OC", viewId: "f_sp_lt", code: "$0.heightAnchor.constraint(equalToConstant: 0.5)"),
        .init(constraintId: "bgL-dw-Ovb", viewId: "aji_it_jr", code: "$0.trailingAnchor.constraint(equalTo: pxc_s_zhx.trailingAnchor)"),
        .init(constraintId: "jIP-0T-GXi", viewId: "aji_it_jr", code: "$0.bottomAnchor.constraint(equalTo: pxc_s_zhx.bottomAnchor)"),
        .init(constraintId: "ic0-HK-KNH", viewId: "aji_it_jr", code: "$0.topAnchor.constraint(equalTo: pxc_s_zhx.topAnchor)"),
        .init(constraintId: "DXb-dP-1Mc", viewId: "aji_it_jr", code: "$0.widthAnchor.constraint(equalToConstant: 50)"),
        .init(constraintId: "nfZ-fb-ogz", viewId: "vkn_pv_ub", code: "$0.trailingAnchor.constraint(equalTo: gpw_lh_thk.trailingAnchor)"),
        .init(constraintId: "PQH-iT-wbm", viewId: "vkn_pv_ub", code: "$0.leadingAnchor.constraint(equalTo: gpw_lh_thk.leadingAnchor)"),
        .init(constraintId: "llc-2k-fUC", viewId: "vkn_pv_ub", code: "$0.bottomAnchor.constraint(equalTo: gpw_lh_thk.bottomAnchor)"),
        .init(constraintId: "jFY-ZR-5uw", viewId: "vkn_pv_ub", code: "$0.topAnchor.constraint(equalTo: is_gj_vf.bottomAnchor, constant: 20)"),
        .init(constraintId: "AsW-0z-fow", viewId: "ua_aj_mg", code: "$0.trailingAnchor.constraint(equalTo: bak_su_h.safeAreaLayoutGuide.trailingAnchor)"),
        .init(constraintId: "Yi8-bb-huj", viewId: "ua_aj_mg", code: "$0.leadingAnchor.constraint(equalTo: bak_su_h.safeAreaLayoutGuide.leadingAnchor)"),
        .init(constraintId: "gT6-dB-XQS", viewId: "ua_aj_mg", code: "$0.topAnchor.constraint(equalTo: gpw_lh_thk.bottomAnchor, constant: 33)"),
        .init(constraintId: "Eoq-99-zbW", viewId: "wf_jg_goa", code: "$0.centerXAnchor.constraint(equalTo: ua_aj_mg.centerXAnchor)"),
        .init(constraintId: "BL4-mf-sWk", viewId: "wf_jg_goa", code: "$0.bottomAnchor.constraint(equalTo: ua_aj_mg.bottomAnchor)"),
        .init(constraintId: "meL-La-Bcj", viewId: "wf_jg_goa", code: "$0.topAnchor.constraint(equalTo: ua_aj_mg.topAnchor)"),
        .init(constraintId: "0Cg-0k-ilF", viewId: "wf_jg_goa", code: "$0.widthAnchor.constraint(equalToConstant: 60)"),
        .init(constraintId: "G7x-Kr-tEX", viewId: "wf_jg_goa", code: "$0.heightAnchor.constraint(equalToConstant: 60)"),
    ]
}

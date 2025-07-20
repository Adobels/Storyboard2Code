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

struct StoryboardBiometricsTests {

    @Test func constraints() throws {
        let url = Bundle.module.url(forResource: "Biometrics", withExtension: "xml")!
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
        .init(constraintId: "JAj-m8-VuO", viewId: "aa_uk_hpz", code: #"$0.topAnchor.constraint(equalTo: ohi_ag_vy.topAnchor)"#),
        .init(constraintId: "wZY-j4-ygi", viewId: "aa_uk_hpz", code: #"$0.bottomAnchor.constraint(equalTo: ohi_ag_vy.bottomAnchor)"#),
        .init(constraintId: "ck7-zr-Zuc", viewId: "aa_uk_hpz", code: #"$0.leadingAnchor.constraint(equalTo: ohi_ag_vy.leadingAnchor)"#),
        .init(constraintId: "el0-J1-Qx1", viewId: "aa_uk_hpz", code: #"$0.trailingAnchor.constraint(equalTo: ohi_ag_vy.trailingAnchor)"#),
        .init(constraintId: "9Yo-en-8O2", viewId: "wzd_rd_jxu", code: #"$0.topAnchor.constraint(equalTo: eny_ip_m.topAnchor)"#),
        .init(constraintId: "kWd-mR-uJf", viewId: "wzd_rd_jxu", code: #"$0.bottomAnchor.constraint(equalTo: eny_ip_m.bottomAnchor)"#),
        .init(constraintId: "sUV-DS-kWx", viewId: "wzd_rd_jxu", code: #"$0.leadingAnchor.constraint(equalTo: eny_ip_m.leadingAnchor)"#),
        .init(constraintId: "uzW-Bl-viM", viewId: "wzd_rd_jxu", code: #"$0.trailingAnchor.constraint(equalTo: eny_ip_m.trailingAnchor)"#),
        .init(constraintId: "HoM-Sg-2BW", viewId: "go_xy_sn", code: #"$0.topAnchor.constraint(equalTo: coz_oz_wc.topAnchor)"#),
        .init(constraintId: "Fnc-eh-aCS", viewId: "go_xy_sn", code: #"$0.bottomAnchor.constraint(equalTo: coz_oz_wc.bottomAnchor)"#),
        .init(constraintId: "P0g-o0-OYZ", viewId: "go_xy_sn", code: #"$0.leadingAnchor.constraint(equalTo: coz_oz_wc.leadingAnchor)"#),
        .init(constraintId: "bhD-9X-vn2", viewId: "go_xy_sn", code: #"$0.trailingAnchor.constraint(equalTo: coz_oz_wc.trailingAnchor)"#),
        .init(constraintId: "5X5-x7-3Td", viewId: "coz_oz_wc", code: #"$0.bottomAnchor.constraint(lessThanOrEqualTo: per_y_qqk.bottomAnchor, constant: -33)"#),
        .init(constraintId: "oaq-H4-TvR", viewId: "coz_oz_wc", code: #"$0.topAnchor.constraint(greaterThanOrEqualTo: jgl_v_lt.bottomAnchor, constant: 20)"#),
        .init(constraintId: "gga-Fm-cdz", viewId: "coz_oz_wc", code: #"$0.bottomAnchor.constraint(equalTo: per_y_qqk.safeAreaLayoutGuide.bottomAnchor, constant: 13).ibPriority(.defaultHigh)"#),
        .init(constraintId: "YMS-OG-r4O", viewId: "coz_oz_wc", code: #"$0.leadingAnchor.constraint(equalTo: per_y_qqk.safeAreaLayoutGuide.leadingAnchor, constant: 33)"#),
        .init(constraintId: "N6f-Zc-Pmv", viewId: "coz_oz_wc", code: #"$0.trailingAnchor.constraint(equalTo: per_y_qqk.safeAreaLayoutGuide.trailingAnchor, constant: -33)"#),
        .init(constraintId: "flO-bt-Nal", viewId: "me_i_itf", code: #"$0.topAnchor.constraint(equalTo: mx_da_obu.bottomAnchor, constant: 15)"#),
        .init(constraintId: "c9f-ip-FeP", viewId: "me_i_itf", code: #"$0.bottomAnchor.constraint(equalTo: jgl_v_lt.bottomAnchor)"#),
        .init(constraintId: "HIC-nu-f3k", viewId: "me_i_itf", code: #"$0.leadingAnchor.constraint(equalTo: jgl_v_lt.leadingAnchor)"#),
        .init(constraintId: "rwb-gR-zEd", viewId: "me_i_itf", code: #"$0.trailingAnchor.constraint(equalTo: jgl_v_lt.trailingAnchor)"#),
        .init(constraintId: "Rxg-VU-fWy", viewId: "me_i_itf", code: #"$0.centerXAnchor.constraint(equalTo: jgl_v_lt.centerXAnchor)"#),
        .init(constraintId: "Jwo-wd-1Zm", viewId: "mx_da_obu", code: #"$0.topAnchor.constraint(equalTo: omo_k_py.bottomAnchor, constant: 24)"#),
        .init(constraintId: "k2t-O8-Cyf", viewId: "mx_da_obu", code: #"$0.leadingAnchor.constraint(equalTo: jgl_v_lt.leadingAnchor)"#),
        .init(constraintId: "a1f-a5-J3Z", viewId: "mx_da_obu", code: #"$0.trailingAnchor.constraint(equalTo: jgl_v_lt.trailingAnchor)"#),
        .init(constraintId: "MLi-jY-msw", viewId: "mx_da_obu", code: #"$0.centerXAnchor.constraint(equalTo: jgl_v_lt.centerXAnchor)"#),
        .init(constraintId: "xBr-PU-J84", viewId: "omo_k_py", code: #"$0.topAnchor.constraint(equalTo: jgl_v_lt.topAnchor)"#),
        .init(constraintId: "dri-Pm-1Kx", viewId: "omo_k_py", code: #"$0.centerXAnchor.constraint(equalTo: jgl_v_lt.centerXAnchor)"#),
        .init(constraintId: "lbd-a3-xW1", viewId: "jgl_v_lt", code: #"$0.topAnchor.constraint(greaterThanOrEqualTo: mqc_pi_emm.bottomAnchor, constant: 20)"#),
        .init(constraintId: "cZZ-r4-Pbv", viewId: "jgl_v_lt", code: #"$0.leadingAnchor.constraint(equalTo: per_y_qqk.safeAreaLayoutGuide.leadingAnchor, constant: 44)"#),
        .init(constraintId: "9bo-zQ-JLb", viewId: "jgl_v_lt", code: #"$0.centerYAnchor.constraint(equalTo: per_y_qqk.centerYAnchor, constant: -50).ibPriority(.defaultLow)"#),
        .init(constraintId: "tw6-Ta-hEY", viewId: "jgl_v_lt", code: #"$0.trailingAnchor.constraint(equalTo: per_y_qqk.safeAreaLayoutGuide.trailingAnchor, constant: -44)"#),
        .init(constraintId: "3a3-o2-qAs", viewId: "mqc_pi_emm", code: #"$0.topAnchor.constraint(equalTo: per_y_qqk.safeAreaLayoutGuide.topAnchor, constant: 34)"#),
        .init(constraintId: "azL-u6-fXZ", viewId: "mqc_pi_emm", code: #"$0.leadingAnchor.constraint(equalTo: per_y_qqk.safeAreaLayoutGuide.leadingAnchor, constant: 33)"#),
        .init(constraintId: "Wuk-JQ-quH", viewId: "qf_uh_shm", code: #"$0.topAnchor.constraint(equalTo: per_y_qqk.topAnchor)"#),
        .init(constraintId: "yeO-9X-8xR", viewId: "qf_uh_shm", code: #"$0.bottomAnchor.constraint(equalTo: per_y_qqk.bottomAnchor)"#),
        .init(constraintId: "p6m-3V-qV9", viewId: "qf_uh_shm", code: #"$0.leadingAnchor.constraint(equalTo: per_y_qqk.leadingAnchor)"#),
        .init(constraintId: "Vs7-GQ-lJ7", viewId: "qf_uh_shm", code: #"$0.trailingAnchor.constraint(equalTo: per_y_qqk.trailingAnchor)"#),
    ]
}

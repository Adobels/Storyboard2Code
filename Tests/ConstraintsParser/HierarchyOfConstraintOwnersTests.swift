//
//  HierarchyOfConstraintOwnersTests.swift
//  story2code
//
//  Created by Blazej Sleboda on 18/07/2025.
//

import Testing
import Foundation
import StoryboardDecoder
@testable import story2code

struct HierarchyOfConstraintOwnersTests {

    @Test func constraints() throws {
        let expected = [
            ("aa_uk_hpz", #"$0.topAnchor.constraint(equalTo: ohi_ag_vy.topAnchor)"#),
            ("aa_uk_hpz", #"$0.bottomAnchor.constraint(equalTo: ohi_ag_vy.bottomAnchor)"#),
            ("aa_uk_hpz", #"$0.leadingAnchor.constraint(equalTo: ohi_ag_vy.leadingAnchor)"#),
            ("aa_uk_hpz", #"$0.trailingAnchor.constraint(equalTo: ohi_ag_vy.trailingAnchor)"#),
            ("wzd_rd_jxu", #"$0.topAnchor.constraint(equalTo: eny_ip_m.topAnchor)"#),
            ("wzd_rd_jxu", #"$0.bottomAnchor.constraint(equalTo: eny_ip_m.bottomAnchor)"#),
            ("wzd_rd_jxu", #"$0.leadingAnchor.constraint(equalTo: eny_ip_m.leadingAnchor)"#),
            ("wzd_rd_jxu", #"$0.trailingAnchor.constraint(equalTo: eny_ip_m.trailingAnchor)"#),
            ("go_xy_sn", #"$0.topAnchor.constraint(equalTo: coz_oz_wc.topAnchor)"#),
            ("go_xy_sn", #"$0.bottomAnchor.constraint(equalTo: coz_oz_wc.bottomAnchor)"#),
            ("go_xy_sn", #"$0.leadingAnchor.constraint(equalTo: coz_oz_wc.leadingAnchor)"#),
            ("go_xy_sn", #"$0.trailingAnchor.constraint(equalTo: coz_oz_wc.trailingAnchor)"#),
            ("coz_oz_wc", #"$0.bottomAnchor.constraint(lessThanOrEqual: per_y_qqk.bottomAnchor, constant: -33)"#),
            ("coz_oz_wc", #"$0.topAnchor.constraint(greaterThanOrEqual: jgl_v_lt.bottomAnchor, constant: 20)"#),
            ("coz_oz_wc", #"$0.bottomAnchor.constraint(equalTo: per_y_qqk.safeAreaLayoutGuide.bottomAnchor, constant: 13).ibPriority(.defaultHigh))"#),
            ("coz_oz_wc", #"$0.leadingAnchor.constraint(equalTo: per_y_qqk.safeAreaLayoutGuide.leadingAnchor, constant: 33)"#),
            ("coz_oz_wc", #"$0.trailingAnchor.constraint(equalTo: per_y_qqk.safeAreaLayoutGuide.trailingAnchor, constant: -33)"#),
            ("me_i_itf", #"$0.topAnchor.constraint(equalTo: mx_da_obu.bottomAnchor, constant: 15)"#),
            ("me_i_itf", #"$0.bottomAnchor.constraint(equalTo: jgl_v_lt.bottomAnchor)"#),
            ("me_i_itf", #"$0.leadingAnchor.constraint(equalTo: jgl_v_lt.leadingAnchor)"#),
            ("me_i_itf", #"$0.trailingAnchor.constraint(equalTo: jgl_v_lt.trailingAnchor)"#),
            ("me_i_itf", #"$0.centerX.constraint(equalTo: jgl_v_lt.centerXAnchor)"#),
            ("mx_da_obu", #"$0.topAnchor.constraint(equalTo: omo_k_py.bottomAnchor, constant: 24)"#),
            ("mx_da_obu", #"$0.leadingAnchor.constraint(equalTo: jgl_v_lt.leadingAnchor)"#),
            ("mx_da_obu", #"$0.trailingAnchor.constraint(equalTo: jgl_v_lt.trailingAnchor)"#),
            ("mx_da_obu", #"$0.centerXAnchor.constraint(equalTo: jgl_v_lt.centerXAnchor)"#),
            ("omo_k_py", #"$0.topAnchor.constraint(equalTo: jgl_v_lt.topAnchor)"#),
            ("omo_k_py", #"$0.centerXAnchor.constraint(equalTo: jgl_v_lt.centerXAnchor)"#),
            ("jgl_v_lt", #"$0.topAnchor.constraint(greaterThanOrEqualTo: mqc_pi_emm.bottomAnchor, constant: 20)"#),
            ("jgl_v_lt", #"$0.leadingAnchor.constraint(equalTo: per_y_qqk.leadingAnchor, constant: 44)"#),
            ("jgl_v_lt", #"$0.centerYAnchor.constraint(equalTo: per_y_qqk.centerYAnchor, constant: -50).ibPriority(.defaultLow)"#),
            ("jgl_v_lt", #"$0.trailingAnchor.constraint(equalTo: per_y_qqk.safeAreaLayoutGuide.trailingAnchor, constant: -44)"#),
            ("mqc_pi_emm", #"$0.topAnchor.constraint(equalTo: per_y_qqk.safeAreaLayoutGuide.topAnchor, constant: 34)"#),
            ("mqc_pi_emm", #"$0.leadingAnchor.constraint(equalTo: per_y_qqk.safeAreaLayoutGuide.leadingAnchor, constant: 33)"#),
            ("qf_uh_shm", #"$0.topAnchor.constraint(equalTo: per_y_qqk.topAnchor)"#),
            ("qf_uh_shm", #"$0.bottomAnchor.constraint(equalTo: per_y_qqk.bottomAnchor)"#),
            ("qf_uh_shm", #"$0.leadingAnchor.constraint(equalTo: per_y_qqk.leadingAnchor)"#),
            ("qf_uh_shm", #"$0.trailingAnchor.constraint(equalTo: per_y_qqk.trailingAnchor)"#),
        ]
        let url = Bundle.module.url(forResource: "Biometrics", withExtension: "xml")!
        let sb = try StoryboardFile(url: url)
        guard let initialScene = sb.document.scenes?.first else { throw AppError.isNill }
        guard let viewController = initialScene.viewController else { throw AppError.isNill }
        guard let rootView = viewController.viewController.rootView as? View else { throw AppError.isNill }
        let result = convertConstraintsToCode(rootView: rootView).reversed()
        #expect(result.count == expected.count)

        var found: [(String, String)] = []
        var missing: [(String, String)] = []
        result.forEach { item in
            let contains: Bool = expected.contains(where: { $0.1 == item.1 })
            if contains {
                found.append(item)
            } else {
                missing.append(item)
            }
            #expect(contains)
        }
        print("FOUND (\(found.count)): ")
        found.forEach {
            print("\($0.0), \($0.1)", separator: "\n")
        }

        print("MISSING (\(missing.count)): ")
        missing.forEach {
            print("\($0.0), \($0.1)", separator: "\n")
        }
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
}

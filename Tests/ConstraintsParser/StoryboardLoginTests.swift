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

@MainActor
struct StoryboardLoginTests {

    @Test func constraints() throws {
        let url = Bundle.module.url(forResource: "Login", withExtension: "xml")!
        let sb = try StoryboardFile(url: url)
        guard let initialScene = sb.document.scenes?.first else { throw AppError.isNill }
        guard let rootView = initialScene.viewController?.viewController.rootView as? View else { throw AppError.isNill }
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
            .init(actionId: "apr-73-iAm", ownerId: "ek5-ql-irC", code: "$0.addTarget(self, action: #selector(didTapIdentifierClearButton), for: .touchUpInside)"),
            .init(actionId: "piM-N8-QFT", ownerId: "aJi-IT-j9R", code: "$0.addTarget(self, action: #selector(didTapPasswordButton), for: .touchUpInside)"),
            .init(actionId: "ctX-CB-SMJ", ownerId: "vkN-PV-1Ub", code: "$0.addTarget(self, action: #selector(login(_:)), for: .touchUpInside)"),
            .init(actionId: "iSO-Sl-8ys", ownerId: "1Wf-Jg-gOa", code: "$0.addTarget(self, action: #selector(biometrics(_:)), for: .touchUpInside)"),
            .init(actionId: "P10-Sh-wge", ownerId: "kVf-kS-YQ3", code: "$0.addTarget(self, action: #selector(dismissKeyboard(gesture:)))")
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
        .init(constraintId: "Kzp-3r-Tnb", viewId: "eo3-u4-K6S", code: "$0.bottomAnchor.constraint(equalTo: baK-Su-87H.bottomAnchor)"),
        .init(constraintId: "ff8-JT-ZyT", viewId: "eo3-u4-K6S", code: "$0.topAnchor.constraint(equalTo: baK-Su-87H.topAnchor)"),
        .init(constraintId: "wiF-pi-7eO", viewId: "eo3-u4-K6S", code: "$0.trailingAnchor.constraint(equalTo: baK-Su-87H.safeAreaLayoutGuide.trailingAnchor)"),
        .init(constraintId: "N0b-8V-8So", viewId: "eo3-u4-K6S", code: "$0.leadingAnchor.constraint(equalTo: baK-Su-87H.safeAreaLayoutGuide.leadingAnchor)"),
        .init(constraintId: "m6b-R0-hAT", viewId: "rLT-p4-vqM", code: "$0.trailingAnchor.constraint(equalTo: baK-Su-87H.safeAreaLayoutGuide.trailingAnchor)"),
        .init(constraintId: "dNa-6s-1D2", viewId: "rLT-p4-vqM", code: "$0.leadingAnchor.constraint(equalTo: baK-Su-87H.safeAreaLayoutGuide.leadingAnchor)"),
        .init(constraintId: "ZLN-2t-t8Y", viewId: "rLT-p4-vqM", code: "$0.topAnchor.constraint(equalTo: baK-Su-87H.safeAreaLayoutGuide.topAnchor)"),
        .init(constraintId: "qar-hB-RMS", viewId: "Th6-o1-fRg", code: "$0.centerXAnchor.constraint(equalTo: rLT-p4-vqM.centerXAnchor)"),
        .init(constraintId: "M0W-DR-OVN", viewId: "Th6-o1-fRg", code: "$0.centerYAnchor.constraint(equalTo: rLT-p4-vqM.centerYAnchor).ibPriority(.defaultHigh)"),
        .init(constraintId: "6Lq-qL-0lz", viewId: "Th6-o1-fRg", code: "$0.bottomAnchor.constraint(lessThanOrEqualTo: rLT-p4-vqM.bottomAnchor, constant: -10)"),
        .init(constraintId: "kYz-Gw-vwl", viewId: "Th6-o1-fRg", code: "$0.topAnchor.constraint(greaterThanOrEqualTo: rLT-p4-vqM.topAnchor, constant: 20)"),
        .init(constraintId: "VP1-EE-53O", viewId: "W4l-pd-zxI", code: "$0.leadingAnchor.constraint(equalTo: rLT-p4-vqM.leadingAnchor, constant: 33)"),
        .init(constraintId: "rhI-pp-Jon", viewId: "W4l-pd-zxI", code: "$0.bottomAnchor.constraint(lessThanOrEqualTo: rLT-p4-vqM.bottomAnchor, constant: -16)"),
        .init(constraintId: "JDa-lt-4Af", viewId: "W4l-pd-zxI", code: "$0.topAnchor.constraint(equalTo: rLT-p4-vqM.topAnchor, constant: 34)"),
        .init(constraintId: "gMH-aP-ooO", viewId: "gpW-lH-thK", code: "$0.bottomAnchor.constraint(lessThanOrEqualTo: baK-Su-87H.safeAreaLayoutGuide.bottomAnchor)"),
        .init(constraintId: "lMJ-jk-4N4", viewId: "gpW-lH-thK", code: "$0.centerXAnchor.constraint(equalTo: baK-Su-87H.centerXAnchor)"),
        .init(constraintId: "wHp-Up-hRQ", viewId: "gpW-lH-thK", code: "$0.centerYAnchor.constraint(equalTo: baK-Su-87H.centerYAnchor, constant: -40).ibPriority(.init(500))"),
        .init(constraintId: "uES-gS-m9z", viewId: "gpW-lH-thK", code: #"$0.widthAnchor.constraint(equalTo: baK-Su-87H.widthAnchor, multiplier: 0.81)"#),
        .init(constraintId: "YNx-bN-Hy5", viewId: "gpW-lH-thK", code: "$0.topAnchor.constraint(equalTo: rLT-p4-vqM.bottomAnchor)"),
        .init(constraintId: "QcP-JM-ovN", viewId: "XN7-gt-jHw", code: "$0.trailingAnchor.constraint(equalTo: gpW-lH-thK.trailingAnchor)"),
        .init(constraintId: "hJk-6F-09W", viewId: "XN7-gt-jHw", code: "$0.leadingAnchor.constraint(equalTo: gpW-lH-thK.leadingAnchor)"),
        .init(constraintId: "Bsa-6r-u7Q", viewId: "XN7-gt-jHw", code: "$0.topAnchor.constraint(equalTo: gpW-lH-thK.topAnchor)"),
        .init(constraintId: "MME-LI-81G", viewId: "iS7-gJ-v3f", code: "$0.trailingAnchor.constraint(equalTo: gpW-lH-thK.trailingAnchor)"),
        .init(constraintId: "aiW-Dp-wbV", viewId: "iS7-gJ-v3f", code: "$0.leadingAnchor.constraint(equalTo: gpW-lH-thK.leadingAnchor)"),
        .init(constraintId: "XNH-P9-lAS", viewId: "iS7-gJ-v3f", code: "$0.topAnchor.constraint(equalTo: XN7-gt-jHw.bottomAnchor, constant: 26).ibPriority(.defaultLow)"),
        .init(constraintId: "ful-HK-GTn", viewId: "iS7-gJ-v3f", code: "$0.topAnchor.constraint(greaterThanOrEqualTo: XN7-gt-jHw.bottomAnchor, constant: 16)"),
        .init(constraintId: "Ruq-9T-E9D", viewId: "iS7-gJ-v3f", code: "$0.heightAnchor.constraint(equalToConstant: 120)"),
        .init(constraintId: "tQQ-sF-Rmb", viewId: "YH4-TE-dSf", code: "$0.trailingAnchor.constraint(equalTo: iS7-gJ-v3f.trailingAnchor)"),
        .init(constraintId: "nfj-4t-1lx", viewId: "YH4-TE-dSf", code: "$0.leadingAnchor.constraint(equalTo: iS7-gJ-v3f.leadingAnchor)"),
        .init(constraintId: "O8V-rW-hrv", viewId: "YH4-TE-dSf", code: "$0.topAnchor.constraint(equalTo: iS7-gJ-v3f.topAnchor)"),
        .init(constraintId: "1Qt-aM-kno", viewId: "YH4-TE-dSf", code: "$0.heightAnchor.constraint(equalToConstant: 60)"),
        .init(constraintId: "DuT-U9-asn", viewId: "0U7-o5-kKu", code: "$0.trailingAnchor.constraint(equalTo: YH4-TE-dSf.trailingAnchor)"),
        .init(constraintId: "CNj-Yc-JHO", viewId: "0U7-o5-kKu", code: "$0.leadingAnchor.constraint(equalTo: YH4-TE-dSf.leadingAnchor)"),
        .init(constraintId: "Ii5-Jr-Hpy", viewId: "0U7-o5-kKu", code: "$0.bottomAnchor.constraint(equalTo: YH4-TE-dSf.bottomAnchor)"),
        .init(constraintId: "duE-Hf-4UY", viewId: "0U7-o5-kKu", code: "$0.topAnchor.constraint(equalTo: YH4-TE-dSf.topAnchor)"),
        .init(constraintId: "Wj0-CX-cbk", viewId: "EYg-Tt-zDJ", code: "$0.centerYAnchor.constraint(equalTo: 0U7-o5-kKu.centerYAnchor)"),
        .init(constraintId: "wqx-cO-Jjs", viewId: "EYg-Tt-zDJ", code: "$0.leadingAnchor.constraint(equalTo: 0U7-o5-kKu.leadingAnchor, constant: 18)"),
        .init(constraintId: "2IB-Nd-Y8U", viewId: "ek5-ql-irC", code: "$0.trailingAnchor.constraint(equalTo: 0U7-o5-kKu.trailingAnchor)"),
        .init(constraintId: "QY1-7L-Qmw", viewId: "ek5-ql-irC", code: "$0.bottomAnchor.constraint(equalTo: 0U7-o5-kKu.bottomAnchor)"),
        .init(constraintId: "gcK-fd-2Kj", viewId: "ek5-ql-irC", code: "$0.topAnchor.constraint(equalTo: 0U7-o5-kKu.topAnchor)"),
        .init(constraintId: "mcC-4F-l0f", viewId: "ek5-ql-irC", code: "$0.leadingAnchor.constraint(equalTo: EYg-Tt-zDJ.trailingAnchor)"),
        .init(constraintId: "eYV-jJ-yAe", viewId: "ek5-ql-irC", code: "$0.widthAnchor.constraint(equalToConstant: 50)"),
        .init(constraintId: "JOT-se-4yM", viewId: "PxC-7S-Zhx", code: "$0.trailingAnchor.constraint(equalTo: iS7-gJ-v3f.trailingAnchor)"),
        .init(constraintId: "TA9-5f-WeM", viewId: "PxC-7S-Zhx", code: "$0.leadingAnchor.constraint(equalTo: iS7-gJ-v3f.leadingAnchor)"),
        .init(constraintId: "XWn-ux-cJ1", viewId: "PxC-7S-Zhx", code: "$0.bottomAnchor.constraint(equalTo: iS7-gJ-v3f.bottomAnchor)"),
        .init(constraintId: "ZFX-2Y-nZ3", viewId: "PxC-7S-Zhx", code: "$0.topAnchor.constraint(equalTo: YH4-TE-dSf.bottomAnchor)"),
        .init(constraintId: "KUx-lF-Tef", viewId: "PxC-7S-Zhx", code: "$0.heightAnchor.constraint(equalToConstant: 60)"),
        .init(constraintId: "2yM-cS-I7I", viewId: "43F-SP-LT6", code: "$0.trailingAnchor.constraint(equalTo: iS7-gJ-v3f.trailingAnchor)"),
        .init(constraintId: "tKy-bi-jZM", viewId: "43F-SP-LT6", code: "$0.leadingAnchor.constraint(equalTo: iS7-gJ-v3f.leadingAnchor)"),
        .init(constraintId: "yia-w1-q66", viewId: "43F-SP-LT6", code: "$0.topAnchor.constraint(equalTo: YH4-TE-dSf.bottomAnchor)"),
        .init(constraintId: "Fty-Yl-5OC", viewId: "43F-SP-LT6", code: "$0.heightAnchor.constraint(equalToConstant: 0.5)"),
        .init(constraintId: "bgL-dw-Ovb", viewId: "aJi-IT-j9R", code: "$0.trailingAnchor.constraint(equalTo: PxC-7S-Zhx.trailingAnchor)"),
        .init(constraintId: "jIP-0T-GXi", viewId: "aJi-IT-j9R", code: "$0.bottomAnchor.constraint(equalTo: PxC-7S-Zhx.bottomAnchor)"),
        .init(constraintId: "ic0-HK-KNH", viewId: "aJi-IT-j9R", code: "$0.topAnchor.constraint(equalTo: PxC-7S-Zhx.topAnchor)"),
        .init(constraintId: "DXb-dP-1Mc", viewId: "aJi-IT-j9R", code: "$0.widthAnchor.constraint(equalToConstant: 50)"),
        .init(constraintId: "nfZ-fb-ogz", viewId: "vkN-PV-1Ub", code: "$0.trailingAnchor.constraint(equalTo: gpW-lH-thK.trailingAnchor)"),
        .init(constraintId: "PQH-iT-wbm", viewId: "vkN-PV-1Ub", code: "$0.leadingAnchor.constraint(equalTo: gpW-lH-thK.leadingAnchor)"),
        .init(constraintId: "llc-2k-fUC", viewId: "vkN-PV-1Ub", code: "$0.bottomAnchor.constraint(equalTo: gpW-lH-thK.bottomAnchor)"),
        .init(constraintId: "jFY-ZR-5uw", viewId: "vkN-PV-1Ub", code: "$0.topAnchor.constraint(equalTo: iS7-gJ-v3f.bottomAnchor, constant: 20)"),
        .init(constraintId: "AsW-0z-fow", viewId: "5uA-AJ-mG0", code: "$0.trailingAnchor.constraint(equalTo: baK-Su-87H.safeAreaLayoutGuide.trailingAnchor)"),
        .init(constraintId: "Yi8-bb-huj", viewId: "5uA-AJ-mG0", code: "$0.leadingAnchor.constraint(equalTo: baK-Su-87H.safeAreaLayoutGuide.leadingAnchor)"),
        .init(constraintId: "gT6-dB-XQS", viewId: "5uA-AJ-mG0", code: "$0.topAnchor.constraint(equalTo: gpW-lH-thK.bottomAnchor, constant: 33)"),
        .init(constraintId: "Eoq-99-zbW", viewId: "1Wf-Jg-gOa", code: "$0.centerXAnchor.constraint(equalTo: 5uA-AJ-mG0.centerXAnchor)"),
        .init(constraintId: "BL4-mf-sWk", viewId: "1Wf-Jg-gOa", code: "$0.bottomAnchor.constraint(equalTo: 5uA-AJ-mG0.bottomAnchor)"),
        .init(constraintId: "meL-La-Bcj", viewId: "1Wf-Jg-gOa", code: "$0.topAnchor.constraint(equalTo: 5uA-AJ-mG0.topAnchor)"),
        .init(constraintId: "0Cg-0k-ilF", viewId: "1Wf-Jg-gOa", code: "$0.widthAnchor.constraint(equalToConstant: 60)"),
        .init(constraintId: "G7x-Kr-tEX", viewId: "1Wf-Jg-gOa", code: "$0.heightAnchor.constraint(equalToConstant: 60)"),
    ]
}

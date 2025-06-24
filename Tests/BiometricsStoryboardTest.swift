//
//  BiometricsStoryboardTest.swift
//  story2code
//
//  Created by Blazej Sleboda on 17/06/2025.
//

import Testing
import Foundation
@testable import story2code
import StoryboardDecoder

@MainActor @Test func testOutputBiometric() async throws {
    let url = Bundle.module.url(forResource: "Biometrics", withExtension: "xml")!
    let sb = try! StoryboardFile(url: url)
    let initialScene = sb.document.scenes!.first!

    let output: [String] = convertStoryboard2Code(initialScene.viewController!)
    print(output)
    let outputBiometricsLines = outputBiometrics.components(separatedBy: "\n").map { String($0) }
    #expect(outputBiometricsLines.count == 169)
    #expect(outputBiometricsLines.count == output.count)
    outputBiometricsLines.enumerated().forEach {
        let lhs = $0.element
        let rhs = output[$0.offset]
        if lhs != rhs {
            print(lhs)
            print(rhs)
        }
        #expect($0.element == output[$0.offset])
    }
}

let outputBiometrics = """
var aa_uk_hpz: LargeButton!
var coz_oz_wc: UIView!
var eny_ip_m: UIView!
var go_xy_sn: UIStackView!
var jgl_v_lt: UIView!
var me_i_itf: CustomLabel!
var mqc_pi_emm: UIImageView!
var mx_da_obu: CustomLabel!
var ohi_ag_vy: UIView!
var omo_k_py: AnimatedView!
var qf_uh_shm: UIImageView!
var wzd_rd_jxu: LargeButton!
.ibSubviews {
UIImageView() //  qf_uh_shm viewName 0 userLabel: nil key: nil
.ibOutlet(&qf_uh_shm)
.ibAttributes {
$0.trailingAnchor.constraint(equalTo: view.trailingAnchor)
$0.topAnchor.constraint(equalTo: view.topAnchor)
$0.leadingAnchor.constraint(equalTo: view.leadingAnchor)
$0.bottomAnchor.constraint(equalTo: view.bottomAnchor)
$0.image = .backgroundOnboarding
$0.clipsToBounds = true
$0.contentMode = .scaleToFill
$0.isOpaque = false
}
UIImageView() //  mqc_pi_emm viewName 1 userLabel: nil key: nil
.ibOutlet(&mqc_pi_emm)
.ibAttributes {
$0.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 34)
$0.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 33)
$0.image = .navbarOnboardingLogo
$0.clipsToBounds = true
$0.contentMode = .center
$0.isOpaque = false
$0.setContentHuggingPriority(.init(1000), for: .horizontal)
$0.setContentHuggingPriority(.init(1000), for: .vertical)
$0.setContentCompressionResistancePriority(.init(1000), for: .horizontal)
$0.setContentCompressionResistancePriority(.init(1000), for: .vertical)
}
UIView() //  jgl_v_lt viewName 2 userLabel: Optional("ViewContent") key: nil
.ibOutlet(&jgl_v_lt)
.ibSubviews {
AnimatedView() //  omo_k_py viewName 3 userLabel: nil key: nil
.ibOutlet(&animatedView)
.ibAttributes {
$0.centerXAnchor.constraint(equalTo: jgl_v_lt.centerXAnchor)
$0.topAnchor.constraint(equalTo: jgl_v_lt.topAnchor)
$0.contentMode = .scaleToFill
$0.setContentHuggingPriority(.init(500), for: .horizontal)
$0.setContentHuggingPriority(.init(500), for: .vertical)
$0.setContentCompressionResistancePriority(.init(500), for: .horizontal)
$0.setContentCompressionResistancePriority(.init(500), for: .vertical)
}
CustomLabel() //  mx_da_obu viewName 4 userLabel: nil key: nil
.ibOutlet(&labelTitle)
.ibAttributes {
$0.topAnchor.constraint(equalTo: animatedView.bottomAnchor, constant: 24)
$0.centerXAnchor.constraint(equalTo: jgl_v_lt.centerXAnchor)
$0.trailingAnchor.constraint(equalTo: jgl_v_lt.trailingAnchor)
$0.leadingAnchor.constraint(equalTo: jgl_v_lt.leadingAnchor)
$0.text = "dynamic-label"
$0.font = .init(weight: .medium, size: 18)
$0.lineBreakMode = .byTruncatingTail
$0.adjustsFontSizeToFitWidth = false
$0.baselineAdjustment = .alignBaselines
$0.isOpaque = false
$0.setContentHuggingPriority(.init(251), for: .horizontal)
$0.setContentHuggingPriority(.init(251), for: .vertical)
$0.themeStyle = "title"
$0.themeParent = "onboarding"
$0.textLineSpacing = 10
}
CustomLabel() //  me_i_itf viewName 5 userLabel: nil key: nil
.ibOutlet(&labelText)
.ibAttributes {
$0.leadingAnchor.constraint(equalTo: jgl_v_lt.leadingAnchor)
$0.centerXAnchor.constraint(equalTo: jgl_v_lt.centerXAnchor)
$0.bottomAnchor.constraint(equalTo: jgl_v_lt.bottomAnchor)
$0.topAnchor.constraint(equalTo: labelTitle.bottomAnchor, constant: 15)
$0.trailingAnchor.constraint(equalTo: jgl_v_lt.trailingAnchor)
$0.text = "dynamic-label"
$0.font = .init(weight: .regular, size: 16)
$0.lineBreakMode = .byTruncatingTail
$0.adjustsFontSizeToFitWidth = false
$0.baselineAdjustment = .alignBaselines
$0.numberOfLines = 0
$0.isOpaque = false
$0.setContentHuggingPriority(.init(251), for: .horizontal)
$0.setContentHuggingPriority(.init(251), for: .vertical)
$0.themeStyle = "text"
$0.themeParent = "onboarding"
}
}
.ibAttributes {
$0.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50).ibPriority(.init(250))
$0.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 44)
$0.topAnchor.constraint(greaterThanOrEqualTo: mqc_pi_emm.bottomAnchor, constant: 20)
$0.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -44)
$0.contentMode = .scaleToFill
}
UIView() //  coz_oz_wc viewName 6 userLabel: Optional("ViewButtons") key: nil
.ibOutlet(&coz_oz_wc)
.ibSubviews {
UIStackView(axis: .vertical) //  go_xy_sn viewName 7 userLabel: nil key: nil
.ibOutlet(&go_xy_sn)
.ibSubviews {
UIView() //  eny_ip_m viewName 8 userLabel: nil key: nil
.ibOutlet(&eny_ip_m)
.ibSubviews {
LargeButton() //  wzd_rd_jxu viewName 9 userLabel: nil key: nil
.ibOutlet(&buttonActivate)
.ibAttributes {
$0.topAnchor.constraint(equalTo: eny_ip_m.topAnchor)
$0.bottomAnchor.constraint(equalTo: eny_ip_m.bottomAnchor)
$0.leadingAnchor.constraint(equalTo: eny_ip_m.leadingAnchor)
$0.trailingAnchor.constraint(equalTo: eny_ip_m.trailingAnchor)
$0.addTarget(self, action: #selector(configure(button:)), for: .touchUpInside)
$0.contentMode = .scaleToFill
$0.isOpaque = false
$0.style = .confirm
$0.themeParent = "onboarding"
$0.loaderMargin = 13.0
}
}
.ibAttributes {
$0.contentMode = .scaleToFill
}
UIView() //  ohi_ag_vy viewName 10 userLabel: nil key: nil
.ibOutlet(&ohi_ag_vy)
.ibSubviews {
LargeButton() //  aa_uk_hpz viewName 11 userLabel: nil key: nil
.ibOutlet(&buttonSkip)
.ibAttributes {
$0.topAnchor.constraint(equalTo: ohi_ag_vy.topAnchor)
$0.leadingAnchor.constraint(equalTo: ohi_ag_vy.leadingAnchor)
$0.trailingAnchor.constraint(equalTo: ohi_ag_vy.trailingAnchor)
$0.bottomAnchor.constraint(equalTo: ohi_ag_vy.bottomAnchor)
$0.addTarget(self, action: #selector(skip(button:)), for: .touchUpInside)
$0.contentMode = .scaleToFill
$0.isOpaque = false
$0.style = .cancel
$0.themeParent = "onboarding"
$0.loaderPosition = .center
}
}
.ibAttributes {
$0.contentMode = .scaleToFill
}
}
.ibAttributes {
$0.bottomAnchor.constraint(equalTo: coz_oz_wc.bottomAnchor)
$0.topAnchor.constraint(equalTo: coz_oz_wc.topAnchor)
$0.leadingAnchor.constraint(equalTo: coz_oz_wc.leadingAnchor)
$0.trailingAnchor.constraint(equalTo: coz_oz_wc.trailingAnchor)
$0.distribution = .fillEqually
$0.spacing = 10
$0.contentMode = .scaleToFill
$0.isOpaque = false
}
}
.ibAttributes {
$0.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: -33)
$0.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -33)
$0.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 33)
$0.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 13).ibPriority(.init(750))
$0.bottomAnchor.constraint(greaterThanOrEqualTo: jgl_v_lt.topAnchor, constant: 20)
$0.contentMode = .scaleToFill
}
}
"""


//
//  File.swift
//  story2code
//
//  Created by Blazej Sleboda on 16/07/2025.
//

import Testing
import Foundation
import StoryboardDecoder
@testable import story2code

@MainActor
@Suite("Password.storyboard Tests")
struct PasswordTests {

    @Test func testFull() throws {
        let url = Bundle.module.url(forResource: "ToParse", withExtension: "xml")!
        let sb = try! StoryboardFile(url: url)
        let initialScene = sb.document.scenes!.first!
        let result = convertStoryboard2Code(initialScene.viewController!)
        expectedOutput.components(separatedBy: .newlines).enumerated().forEach {
            #expect($0.element == result[$0.offset])
        }
    }

    struct Constraint {
        let firstItem: String
        let firstItemGuide: String
        let firstAttribute: String
        let relation: String
        let secondItem: String
        let secondItemGuide: String
        let secondAttribute: String
        let constant: String
        let priority: String
        let multiplier: String
    }

    @Test() func testConvertPriorityToCode() throws {
        #expect(convertPriority(-1) == ".ibPriority(.init(-1))")
        #expect(convertPriority(0) == ".ibPriority(.init(0))")
        #expect(convertPriority(1) == ".ibPriority(.init(1))")
        #expect(convertPriority(1) == ".ibPriority(.init(1))")
        #expect(convertPriority(250) == ".ibPriority(.defaultLow)")
        #expect(convertPriority(750) == ".ibPriority(.defaultHigh)")
        #expect(convertPriority(1000) == ".ibPriority(.required)")
        #expect(convertPriority(1001) == ".ibPriority(.init(1001))")
        #expect(convertPriority(1002.1) == ".ibPriority(.init(1002))")
    }

    @Test() func testConstantArgument() throws {
        #expect(convertConstant(-1000) == "constant: -1000")
        #expect(convertConstant(-1) == "constant: -1")
        #expect(convertConstant(0) == "constant: 0")
        #expect(convertConstant(1) == "constant: 1")
        #expect(convertConstant(1000) == "constant: 1000")
        #expect(convertConstant(1000.1) == "constant: 1000.1")
        #expect(convertConstant(1000.01) == "constant: 1000.01")
    }

    @Test() func testConvertMultiplierToCode() throws {
        #expect(convertMultiplierToCode("1:1") == "multiplier: 1")
        #expect(convertMultiplierToCode("300:190") == "multiplier: 1.5789474")
        #expect(convertMultiplierToCode("8:10") == "multiplier: 0.8")
        #expect(convertMultiplierToCode("3:2") == "multiplier: 1.5")
        #expect(convertMultiplierToCode("2:3") == "multiplier: 0.6666667")
        #expect(convertMultiplierToCode("0.77") == "multiplier: 0.77")
        #expect(convertMultiplierToCode("0.9") == "multiplier: 0.9")
        #expect(convertMultiplierToCode("1.65") == "multiplier: 1.65")
        #expect(convertMultiplierToCode("-1000") == "multiplier: -1000")
        #expect(convertMultiplierToCode("-1") == "multiplier: -1")
        #expect(convertMultiplierToCode("0") == "multiplier: 0")
        #expect(convertMultiplierToCode("1") == "multiplier: 1")
        #expect(convertMultiplierToCode("1000") == "multiplier: 1000")
        #expect(convertMultiplierToCode("1000.1") == "multiplier: 1000.1")
        #expect(convertMultiplierToCode("1000.01") == "multiplier: 1000.01")
    }

    @Test() func testConvertIdentifierToCode() throws {
        #expect(convertIdentifierToCode(nil) == nil)
        #expect(convertIdentifierToCode("") == nil)
        #expect(convertIdentifierToCode("heightConstraint") == #".ibIdentifier("heightConstraint")"#)
    }

    @Test() func testConvertLayoutAttribute() throws {
        #expect(convertLayoutAttribute("top") == "top")
        #expect(convertLayoutAttribute("leading") == "leading")
        #expect(convertLayoutAttribute("trailing") == "trailing")
        #expect(convertLayoutAttribute("bottom") == "bottom")
        #expect(convertLayoutAttribute("left") == "left")
        #expect(convertLayoutAttribute("right") == "right")
        #expect(convertLayoutAttribute("topMargin") == "top")
        #expect(convertLayoutAttribute("leadingMargin") == "leading")
        #expect(convertLayoutAttribute("trailingMargin") == "trailing")
        #expect(convertLayoutAttribute("rightMargin") == "right")
        #expect(convertLayoutAttribute("bottomMargin") == "bottom")
    }

    @Test func testConvertLayoutAttributeToAnchor() throws {
        #expect(convertLayoutAttributeToAnchor("top") == ".topAnchor")
        #expect(convertLayoutAttributeToAnchor("leading") == ".leadingAnchor")
        #expect(convertLayoutAttributeToAnchor("trailing") == ".trailingAnchor")
        #expect(convertLayoutAttributeToAnchor("bottom") == ".bottomAnchor")
        #expect(convertLayoutAttributeToAnchor("left") == ".leftAnchor")
        #expect(convertLayoutAttributeToAnchor("right") == ".rightAnchor")
        #expect(convertLayoutAttributeToAnchor("topMargin") == ".layoutMarginsGuide.topAnchor")
        #expect(convertLayoutAttributeToAnchor("leadingMargin") == ".layoutMarginsGuide.leadingAnchor")
        #expect(convertLayoutAttributeToAnchor("trailingMargin") == ".layoutMarginsGuide.trailingAnchor")
        #expect(convertLayoutAttributeToAnchor("rightMargin") == ".layoutMarginsGuide.rightAnchor")
        #expect(convertLayoutAttributeToAnchor("bottomMargin") == ".layoutMarginsGuide.bottomAnchor")
    }

    @Test func testConvertConstraintToCode() throws {
        let toto = convertConstraintToCode(
            "YE5-Pe-agX",
            "keyboard",
            "top",
            "greaterThanOrEqual",
            "WX4-pb-dXk",
            nil,
            "bottom",
            constant: 54,
            multiplier: nil,
            priority: 750,
            identifier: nil
        )
        #expect(
            toto?.1 == #"$0.keyboardLayoutGuide.topAnchor.constraint(greaterThanOrEqualTo: wx_pb_dxk.bottomAnchor, constant: 54).ibPriority(.defaultHigh)"#
        )
    }

    @Test func testSomething() throws {
        let constraint = Constraint.init(
            firstItem: "$0",
            firstItemGuide: "",
            firstAttribute: "bottomAnchor",
            relation: "lessThanOrEqualTo",
            secondItem: "view",
            secondItemGuide: "keyboardLayoutGuide",
            secondAttribute: "topAnchor",
            constant: "-54",
            priority: "750",
            multiplier: ""
        )
        func convertToCode(_ constraint: Constraint) -> String {
            var components = [String]()
            components.append(constraint.firstItem)
            components.append(constraint.firstItemGuide)
            components.append(constraint.firstAttribute)
            components.removeAll(where: \.isEmpty)
            let result = components.joined(separator: ".")
            return result
        }

        let result = convertToCode(constraint)
        "$0.bottomMarginAnchor.constraint(lessThanOrEqualTo: view.keyboardLayoutGuide.topAnchor, constant: -54).ibPriority(.init(750))"

        /*"<constraint firstItem="Kyd-BE-YAY" firstAttribute="bottom" secondItem="1l3-KK-xG7" secondAttribute="bottom" priority="750" constant="-13" id="Ki0-1S-3cY"/>"*/
        let expected = "$0.bottomAnchor.constraint(lessThanOrEqualTo: view.keyboardLayoutGuide.topAnchor, constant: -54).ibPriority(.init(750))"
        #expect(result == expected)
    }
}

private let expectedOutput: String = """
var bch_cq_un: UIView!
var db_gm_ysn: UIImageView!
var htz_gy_dv: CustomLabel!
var kyd_be_yay: LargeButton!
var uvr_qa_qh: LargeButton!
var vu_o_ksa: UIImageView!
var wmr_t_ftn: CustomLabel!
var wx_pb_dxk: UIView!
var zie_ud_tu: UIImageView!
var zv_ag_fm: LargeTextField!
.ibSubviews {
UIImageView() //  zie_ud_tu viewName 0 userLabel: nil key: nil
.ibOutlet(&zie_ud_tu)
.ibAttributes {
$0.topAnchor.constraint(equalTo: view.topAnchor)
$0.bottomAnchor.constraint(equalTo: view.bottomAnchor)
$0.leadingAnchor.constraint(equalTo: view.leadingAnchor)
$0.trailingAnchor.constraint(equalTo: view.trailingAnchor)
$0.isMultipleTouchEnabled = true
$0.clipsToBounds = true
$0.contentMode = .scaleToFill
$0.image = .backgroundLogin
}
UIView() //  bch_cq_un viewName 1 userLabel: nil key: nil
.ibOutlet(&bch_cq_un)
.ibSubviews {
UIImageView() //  db_gm_ysn viewName 2 userLabel: nil key: nil
.ibOutlet(&logoCenter)
.ibAttributes {
$0.bottomAnchor.constraint(lessThanOrEqualTo: bch_cq_un.bottomAnchor, constant: -10)
$0.topAnchor.constraint(greaterThanOrEqualTo: bch_cq_un.topAnchor, constant: 20)
$0.centerYAnchor.constraint(equalTo: bch_cq_un.centerYAnchor).ibPriority(.init(750))
$0.centerXAnchor.constraint(equalTo: bch_cq_un.centerXAnchor)
$0.widthAnchor.constraint(equalToConstant: 100)
$0.heightAnchor.constraint(equalToConstant: 100)
$0.isMultipleTouchEnabled = true
$0.clipsToBounds = true
$0.insetsLayoutMarginsFromSafeArea = false
$0.setContentHuggingPriority(.init(251), for: .horizontal)
$0.setContentHuggingPriority(.init(251), for: .vertical)
$0.contentMode = .scaleAspectFit
}
UIImageView() //  vu_o_ksa viewName 3 userLabel: nil key: nil
.ibOutlet(&logoTopLeft)
.ibAttributes {
$0.leadingAnchor.constraint(equalTo: bch_cq_un.leadingAnchor, constant: 33)
$0.bottomAnchor.constraint(lessThanOrEqualTo: bch_cq_un.bottomAnchor, constant: -16)
$0.topAnchor.constraint(equalTo: bch_cq_un.topAnchor, constant: 34)
$0.widthAnchor.constraint(equalToConstant: 50)
$0.heightAnchor.constraint(equalToConstant: 50)
$0.isMultipleTouchEnabled = true
$0.clipsToBounds = true
$0.insetsLayoutMarginsFromSafeArea = false
$0.setContentHuggingPriority(.required, for: .horizontal)
$0.setContentHuggingPriority(.required, for: .vertical)
$0.setContentCompressionResistancePriority(.required, for: .horizontal)
$0.setContentCompressionResistancePriority(.required, for: .vertical)
$0.contentMode = .scaleAspectFit
}
}
.ibAttributes {
$0.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
$0.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
$0.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
$0.backgroundColor = .init(cgColor: .init(genericGrayGamma2_2Gray: 0.0, alpha: 0.0))
}
UIView() //  wx_pb_dxk viewName 4 userLabel: nil key: nil
.ibOutlet(&wx_pb_dxk)
.ibSubviews {
CustomLabel() //  htz_gy_dv viewName 5 userLabel: nil key: nil
.ibOutlet(&htz_gy_dv)
.ibAttributes {
$0.topAnchor.constraint(equalTo: wx_pb_dxk.topAnchor)
$0.leadingAnchor.constraint(equalTo: wx_pb_dxk.leadingAnchor)
$0.trailingAnchor.constraint(equalTo: wx_pb_dxk.trailingAnchor)
$0.isUserInteractionEnabled = false
$0.setContentCompressionResistancePriority(.init(751), for: .horizontal)
$0.setContentCompressionResistancePriority(.init(751), for: .vertical)
$0.font = .init(weight: .regular, size: 35)
$0.lineBreakMode = .byTruncatingTail
$0.minimumScaleFactor = 0.25
$0.numberOfLines = 0
$0.text = Loc.Forgot.title
$0.themeStyle = "title"
$0.themeParent = "login"
$0.textLineSpacing = 6
}
CustomLabel() //  wmr_t_ftn viewName 6 userLabel: nil key: nil
.ibOutlet(&wmr_t_ftn)
.ibAttributes {
$0.topAnchor.constraint(equalTo: htz_gy_dv.bottomAnchor, constant: 20)
$0.trailingAnchor.constraint(equalTo: wx_pb_dxk.trailingAnchor)
$0.leadingAnchor.constraint(equalTo: wx_pb_dxk.leadingAnchor)
$0.isUserInteractionEnabled = false
$0.setContentHuggingPriority(.required, for: .horizontal)
$0.setContentHuggingPriority(.required, for: .vertical)
$0.setContentCompressionResistancePriority(.required, for: .horizontal)
$0.setContentCompressionResistancePriority(.required, for: .vertical)
$0.font = .init(weight: .regular, size: 16)
$0.textAlignment = .natural
$0.lineBreakMode = .byTruncatingTail
$0.adjustsFontSizeToFitWidth = false
$0.baselineAdjustment = .alignBaselines
$0.text = Loc.Forgot.Cell.Identifier.header
$0.themeStyle = "text"
$0.themeParent = "login"
}
LargeTextField() //  zv_ag_fm viewName 7 userLabel: nil key: nil
.ibOutlet(&fieldIdentifier)
.ibAttributes {
$0.trailingAnchor.constraint(equalTo: wx_pb_dxk.trailingAnchor)
$0.leadingAnchor.constraint(equalTo: wx_pb_dxk.leadingAnchor)
$0.topAnchor.constraint(equalTo: wmr_t_ftn.bottomAnchor, constant: 10)
$0.heightAnchor.constraint(equalToConstant: 48)
$0.delegate = ls_rl_baf
$0.clipsToBounds = true
$0.contentHorizontalAlignment = .left
$0.contentVerticalAlignment = .center
$0.font = .init(weight: .regular, size: 16)
$0.placeholder = "label"
$0.clearButtonMode = .always
$0.minimumFontSize = 16.0
$0.adjustsFontSizeToFitWidth = false
$0.autocorrectionType = .no
$0.spellCheckingType = .no
$0.returnKeyType = .done
$0.smartDashesType = .no
$0.smartInsertDeleteType = .no
$0.smartQuotesType = .no
$0.enablesReturnKeyAutomatically = true
$0.locKeyPlaceholder = Loc.Forgot.Cell.Identifier.placeholder
$0.themeParent = "login"
}
LargeButton() //  uvr_qa_qh viewName 8 userLabel: nil key: nil
.ibOutlet(&buttonConfirm)
.ibAttributes {
$0.topAnchor.constraint(equalTo: fieldIdentifier.bottomAnchor, constant: 20)
$0.trailingAnchor.constraint(equalTo: wx_pb_dxk.trailingAnchor)
$0.bottomAnchor.constraint(equalTo: wx_pb_dxk.bottomAnchor)
$0.leadingAnchor.constraint(equalTo: wx_pb_dxk.leadingAnchor)
$0.addTarget(self, action: #selector(send(_:)), for: .touchUpInside)
$0.backgroundColor = .init(cgColor: .init(genericGrayGamma2_2Gray: 0.0, alpha: 1.0))
$0.contentHorizontalAlignment = .center
$0.contentVerticalAlignment = .center
$0.titleLabel?.lineBreakMode = .byTruncatingMiddle
$0.setTitle("LargeButton", for: .normal)
$0.titleLabel?.font = .init(weight: .regular, size: 15)
$0.setTitle(Loc.Forgot.Button.reset, for: .normal)
$0.style = .confirm
$0.themeParent = "login"
$0.loaderPosition = .center
}
}
.ibAttributes {
$0.topAnchor.constraint(lessThanOrEqualTo: view.keyboardLayoutGuide.bottomAnchor, constant: -54).ibPriority(.init(750))
$0.topAnchor.constraint(equalTo: bch_cq_un.bottomAnchor)
$0.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.81)
$0.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -40).ibPriority(.init(500))
$0.centerXAnchor.constraint(equalTo: view.centerXAnchor)
$0.backgroundColor = .init(cgColor: .init(genericGrayGamma2_2Gray: 0.0, alpha: 0.0))
$0.setContentHuggingPriority(.required, for: .horizontal)
$0.setContentHuggingPriority(.required, for: .vertical)
$0.setContentCompressionResistancePriority(.required, for: .horizontal)
$0.setContentCompressionResistancePriority(.required, for: .vertical)
}
LargeButton() //  kyd_be_yay viewName 9 userLabel: nil key: nil
.ibOutlet(&kyd_be_yay)
.ibAttributes {
$0.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: -20)
$0.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -13).ibPriority(.init(750))
$0.centerXAnchor.constraint(equalTo: view.centerXAnchor)
$0.topAnchor.constraint(greaterThanOrEqualTo: wx_pb_dxk.bottomAnchor, constant: 200)
$0.widthAnchor.constraint(equalTo: wx_pb_dxk.widthAnchor)
$0.addTarget(self, action: #selector(dismiss(_:)), for: .touchUpInside)
$0.backgroundColor = .init(cgColor: .init(genericGrayGamma2_2Gray: 0.0, alpha: 1.0))
$0.contentHorizontalAlignment = .center
$0.contentVerticalAlignment = .center
$0.titleLabel?.lineBreakMode = .byTruncatingMiddle
$0.setTitle("LargeButton", for: .normal)
$0.titleLabel?.font = .init(weight: .regular, size: 15)
$0.setTitle(Loc.Forgot.Button.cancel, for: .normal)
$0.style = .cancel
$0.themeParent = "login"
}
}
let vc = PasswordController()
"""

//
//  File.swift
//  story2code
//
//  Created by Blazej Sleboda on 30/07/2025.
//

import Testing
import StoryboardDecoder
@testable import story2code
import Foundation

@MainActor
struct WIPOutletsTests {

    @Test func lala() throws {
        let url = Bundle.module.url(forResource: "WIPOutlets", withExtension: "xml")!
        let sb = try StoryboardFile(url: url)
        guard let initialScene = sb.document.scenes?.first else { throw AppError.isNill }
        let results = parseScene(initialScene)
        results.enumerated().forEach { result in
            #expect(result.element == expectedResults[result.offset])
        }
    }
}

let results = """
// swiftlint:disable identifier_name
var glb_ci_thu: UILabel!
// swiftlint:enable identifier_name
// log: , id: view, sid: ez_qb_rvc, key: view
view
.ibSubviews {
// log: , id: glb-cI-tHU, sid: glb_ci_thu
UILabel()
.ibOutlet(&glb_ci_thu)
.ibOutlet(&self.messageLabel)
.ibAttributes {
$0.setContentHuggingPriority(.init(251), for: .horizontal)
$0.setContentHuggingPriority(.init(251), for: .vertical)
$0.font = .init(weight: .regular, size: 17)
}
}
.ibAttributes {
$0.backgroundColor = .init(named: (key: Optional("backgroundColor"), name: "systemBackgroundColor"))
$0.backgroundColor = RootViewComponentTheme().background
}
let vc = ViewController()
"""

let expectedResults: [String] = [
    #"// swiftlint:disable identifier_name"#,
    #"var glb_ci_thu: UILabel!"#,
    #"// swiftlint:enable identifier_name"#,
    #"// log: , id: view, sid: ez_qb_rvc, key: view"#,
    #"view"#,
    #".ibSubviews {"#,
    #"// log: , id: glb-cI-tHU, sid: glb_ci_thu"#,
    #"UILabel()"#,
    #".ibOutlet(&glb_ci_thu)"#,
    #".ibOutlet(&self.messageLabel)"#,
    #".ibAttributes {"#,
    #"$0.setContentHuggingPriority(.init(251), for: .horizontal)"#,
    #"$0.setContentHuggingPriority(.init(251), for: .vertical)"#,
    #"$0.font = .init(weight: .regular, size: 17)"#,
    #"}"#,
    #"}"#,
    #".ibAttributes {"#,
    #"$0.backgroundColor = .init(named: (key: Optional("backgroundColor"), name: "systemBackgroundColor"))"#,
    #"$0.backgroundColor = RootViewComponentTheme().background"#,
    #"}"#,
    #"let vc = ViewController()"#,
]

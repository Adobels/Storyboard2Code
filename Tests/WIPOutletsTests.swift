//
//  WIPOutletsTests.swift
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

    @MainActor
    @Test func lala() throws {
        guard let url = Bundle.module.url(forResource: "WIPOutlets", withExtension: "xml") else { throw AppError.isNill }
        let sb = try StoryboardFile(url: url)
        guard let initialScene = sb.document.scenes?.first else { throw AppError.isNill }
        let results = parseScene(initialScene)
        results.enumerated().forEach { result in
            try! #require(result.element == expectedResults[result.offset])
        }
    }
}

let expectedResults: [String] = [
    "class ViewController: UIViewController {",
    "required init?(coder: NSCoder) { super.init(coder: coder) }",
    "override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {",
    "super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)",
    "}",
    "override func loadView() {",
    "super.loadView()",
    "// swiftlint:disable identifier_name",
    "var glb_ci_thu: UILabel!",
    "// swiftlint:enable identifier_name",
    "view.ibSubviews {",
    "UILabel().ibOutlet(&glb_ci_thu).ibOutlet(&messageLabel).ibAttributes {",
    "$0.setContentHuggingPriority(.init(251), for: .horizontal)",
    "$0.setContentHuggingPriority(.init(251), for: .vertical)",
    "$0.font = .init(weight: .regular, size: 17)",
    "}",
    "}.ibAttributes {",
    "$0.backgroundColor = .init(named: (key: Optional(\"backgroundColor\"), name: \"systemBackgroundColor\"))",
    "$0.backgroundColor = RootViewComponentTheme().background",
    "}",
    "} // log:  loadView end ",
    "func viewDidLoad() {",
    "super.viewDidLoad()",
    "} // log:  viewDidLoad end",
    "} // log:  class end"
]

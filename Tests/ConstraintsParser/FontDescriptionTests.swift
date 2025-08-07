//
//  FontDescriptionTests.swift
//  story2code
//
//  Created by Blazej Sleboda on 24/07/2025.
//

import Testing
import Foundation
import StoryboardDecoder
@testable import story2code

@MainActor
struct FontDescriptionTests {

    @Test func def() throws {
        guard let url = Bundle.module.url(forResource: "FontDescriptions", withExtension: "xml") else { throw AppError.isNill }
        let sb = try StoryboardFile(url: url)
        guard let rootView = sb.document.scenes?.first?.viewController?.viewController.rootView else { throw AppError.isNill }
        let labels = rootView.children(of: Label.self)
        let fontDescriptions = labels.compactMap { $0.fontDescription }
        let expectedfontDescriptions: [String] = [
            #"system(key: Optional("fontDescription"), type: "system", weight: nil, pointSize: 17.0)"#,
            #"system(key: Optional("fontDescription"), type: "system", weight: Optional("medium"), pointSize: 15.0)"#,
            #"system(key: Optional("fontDescription"), type: "boldSystem", weight: nil, pointSize: 14.0)"#,
            #"custom(key: Optional("fontDescription"), name: "HelveticaNeue-Bold", family: "Helvetica Neue", pointSize: 17.0)"#,
        ]
        fontDescriptions.enumerated().forEach { item in
            #expect("\(item.element)" == expectedfontDescriptions[item.offset])
        }
    }
}

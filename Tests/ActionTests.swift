//
//  File.swift
//  story2code
//
//  Created by Blazej Sleboda on 22/07/2025.
//

import Testing
import Foundation
import StoryboardDecoder
@testable import story2code

struct ActionTests {

    @Test func actions() throws {
        let url = Bundle.module.url(forResource: "Actions", withExtension: "xml")!
        let sb = try StoryboardFile(url: url)
        guard let initialScene = sb.document.scenes?.first else { throw AppError.isNill }
        let actions = extractActions(of: initialScene)
        let expectedActions: [ExtractedAction] = [
            .init(actionId: "Jhv-h4-Cy7", ownerId: "Kme-fC-Usi", code: "$0.addTarget(firstResponder, action: #selector(didTap1), for: .touchUpInside)"),
            .init(actionId: "6qv-F7-Fhy", ownerId: "Kme-fC-Usi", code: "$0.addTarget(self, action: #selector(didTap2), for: .touchUpInside)"),
            .init(actionId: "C7n-zn-nNo", ownerId: "Kme-fC-Usi", code: "$0.addTarget(XPl-8r-sp4, action: #selector(didTap3), for: .touchUpInside)"),
            .init(actionId: "Hat-KN-m6O", ownerId: "ObC-19-cm4", code: "$0.addTarget(firstResponder, action: #selector(copy(_:)))"),
        ]
        #expect(actions.count == expectedActions.count)
        expectedActions.enumerated().forEach { expectedAction in
            #expect(expectedAction.element == actions[expectedAction.offset])
        }
    }
}

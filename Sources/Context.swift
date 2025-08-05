//
//  Context.swift
//  story2code
//
//  Created by Blazej Sleboda on 11/06/2025.
//

import StoryboardDecoder

public class Context: @unchecked Sendable, ParsingOutput, DebugEnabled {

    //static let shared: Context = .init()

    private let scene: Scene
    private let viewController: ViewControllerProtocol
    private let rootView: ViewProtocol

    let viewControllerId: String
    var rootViewId: String
    var visitedIBIdentifiables: [String] = []
    var referencingOutletsMgr: ReferenceOutletsManager!
    var constraints: [ConstraintInCode] = []
    var actions: [ExtractedAction] = []
    var gestures: [AnyGestureRecognizer] = []
    var output: [String] = []
    var debugEnabled = false
    var debugViewMetaEnabled = false

    init(scene: Scene) throws {
        self.scene = scene
        guard let viewController = scene.viewController?.viewController else { throw AppError.isNill }
        self.viewController = viewController
        guard let rootView = viewController.rootView else { throw AppError.isNill }
        self.rootView = rootView
        self.viewControllerId = viewController.id
        self.rootViewId = rootView.id
        self.referencingOutletsMgr = try! .init(scene: scene)
        self.actions = extractActions(of: scene)
        self.gestures = extractGestures(of: scene)
        self.constraints = convertConstraintsToCode(rootView: rootView, ctx: self)
    }

}

protocol ParsingOutput: AnyObject {
    typealias Item = String
    var output: [Item] { get set }
}

protocol DebugEnabled {
    var debugEnabled: Bool { get }
}

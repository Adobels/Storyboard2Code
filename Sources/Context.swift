//
//  Context.swift
//  story2code
//
//  Created by Blazej Sleboda on 11/06/2025.
//

import StoryboardDecoder

class Context: @unchecked Sendable, ParsingOutput, DebugEnabled {

    static let shared: Context = .init()

    private init() {}

    var viewController: AnyViewController!
    //var variableViewIbOutlet: [(viewId: String, viewClass: String)] = []
    //var viewControllerIBOutlets: [(viewId: String, property: String)] = []
    var viewControllerId: String!
    var rootViewId: String!
    var constraints: [ConstraintInCode] = []
    var actions: [ExtractedAction] = []
    var gestures: [AnyGestureRecognizer] = []
    var output: [String] = []
    var debugEnabled = false
    var parsedIBIdentifiables: [String] = []
    var referencingOutletsMgr: ReferenceOutletsManager!
}

protocol ParsingOutput: AnyObject {
    typealias Item = String
    var output: [Item] { get set }
}

protocol DebugEnabled {
    var debugEnabled: Bool { get }
}

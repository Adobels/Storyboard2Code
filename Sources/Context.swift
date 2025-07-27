//
//  Context.swift
//  story2code
//
//  Created by Blazej Sleboda on 11/06/2025.
//

import StoryboardDecoder

class Context: @unchecked Sendable, ParsingOutput {

    static let shared: Context = .init()

    private init() {}

    var viewController: AnyViewController!
    var variableViewIbOutlet: [(viewId: String, viewClass: String)] = []
    var viewControllerIBOutlets: [(viewId: String, property: String)] = []
    var ibOutlet: [S2COutlet] = []
    var constraints: [ConstraintInCode] = []
    var actions: [ExtractedAction] = []
    var constraintsOutlets: [Outlet] = []
    var output: [String] = []
}

protocol ParsingOutput: AnyObject {
    typealias Item = String
    var output: [Item] { get set }
}

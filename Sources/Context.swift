//
//  Context.swift
//  story2code
//
//  Created by Blazej Sleboda on 11/06/2025.
//

import StoryboardDecoder

class Context: @unchecked Sendable {

    static let shared: Context = .init()

    private init() {}

    var viewController: AnyViewController!
    var rootViewControllerId: String!
    var rootViewProtocol: ViewProtocol!
    var rootViewAny: AnyView!
    var rootView: View!
    var variableViewIbOutlet: [(viewId: String, viewClass: String)] = []
    var variableViewIbOutlet2: Set<String> = []
    var viewControllerIBOutlets: [(viewId: String, property: String)] = []
    var ibOutlet: [S2COutlet] = []
    var ibAction: [Action] = []
    var ibViews: Set<String> = []
    var output: [String] = []

    var arrayConstrains: [ConstraintInCode] = []
}

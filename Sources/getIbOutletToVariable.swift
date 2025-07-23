//
//  getIbOutletToVariable.swift
//  story2code
//
//  Created by Blazej Sleboda on 11/06/2025.
//

import StoryboardDecoder

func getIbOutletToVariable(of element: ViewProtocol) -> String? {
    let viewId = element.id
    guard (Context.shared.variableViewIbOutlet2.contains { $0 == viewId }) else { return nil }
    return ".ibOutlet(&\(viewId))"
}

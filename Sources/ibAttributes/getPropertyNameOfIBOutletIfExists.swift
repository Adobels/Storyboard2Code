//
//  getPropertyNameOfIBOutletIfExists.swift
//  story2code
//
//  Created by Blazej Sleboda on 30/07/2025.
//

import Foundation

func getPropertyNameOfIBOutletIfExists(destinationId: String) -> String? {
    if destinationId == Context.shared.viewControllerId {
        return "self"
    } else if destinationId == Context.shared.rootViewId {
        return "view"
    } else {
        let referencingOutlet = Context.shared.referencingOutletsMgr.filterOutletIDsRecursively(matchingId: destinationId).first
        guard let referencingOutlet else { return nil }
        return referencingOutlet.ownerId + "." + referencingOutlet.property
    }
}

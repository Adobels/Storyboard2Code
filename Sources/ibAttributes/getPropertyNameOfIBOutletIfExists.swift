//
//  getPropertyNameOfIBOutletIfExists.swift
//  story2code
//
//  Created by Blazej Sleboda on 30/07/2025.
//

import Foundation

func getPropertyNameOfIBOutletIfExists(destinationId: String, ctx: Context) -> String? {
    if destinationId == ctx.viewControllerId {
        return "self"
    } else if destinationId == ctx.rootViewId {
        return "view"
    } else {
        let referencingOutlet = ctx.referencingOutletsMgr.filterOutletIDsRecursively(matchingId: destinationId).first
        guard let referencingOutlet else { return nil }
        if referencingOutlet.ownerId == ctx.viewControllerId {
            return referencingOutlet.property
        } else {
            return referencingOutlet.ownerId + "." + referencingOutlet.property
        }

    }
}

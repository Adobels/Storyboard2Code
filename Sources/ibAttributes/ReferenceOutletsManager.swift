//
//  ReferenceOutletsManager.swift
//  story2code
//
//  Created by Blazej Sleboda on 30/07/2025.
//

import StoryboardDecoder

class ReferenceOutletsManager {

    var referenceOutlets: [S2COutlet]
    var viewControllerOutlets: [Outlet] = []
    var outletsToApplyLater: [S2COutlet] = []

    init(scene: Scene) {
        referenceOutlets = Self.collectOutletsRecursively(in: scene)
    }

    static func collectOutletsRecursively(in scene: Scene) -> [S2COutlet] {
        var collectedOutlets: [S2COutlet] = []
        scene.browse { element in
            let ownerId: String? = {
                if let view = element as? ViewProtocol {
                    view.id
                } else if let viewController = element as? ViewControllerProtocol {
                    viewController.id
                } else {
                    nil
                }
            }()
            guard let ownerId else { return true }
            guard let connectionOwner = element as? IBConnectionOwner else { return true }
            let outlets = connectionOwner.connections?
                .compactMap { $0.connection as? Outlet }
                .map {
                    S2COutlet(
                        ownerId: ownerId,
                        property: $0.property,
                        destination: $0.destination,
                        isOutletToDestination: true // placeholder
                    )
                }
            collectedOutlets.append(contentsOf: outlets ?? [])
            return true
        }
        return collectedOutlets
    }

    func filterOutletIDsRecursively(matchingId identifiableId: String) -> [S2COutlet] {
        referenceOutlets.filter { $0.destination == identifiableId }
    }

}

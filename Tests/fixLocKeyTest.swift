//
//  fixLocKeyTest.swift
//  story2code
//
//  Created by Blazej Sleboda on 24/06/2025.
//

import Testing
import Foundation
@testable import story2code

@Test func fixLocKey() async throws {
    #expect(
        fixLocKey(value: "login.button.sign_in") == "Loc.Login.Button.signIn"
    )
    #expect(
        fixLocKey(value: "car.electric.create_success.button.confirm") == "Loc.Car.Electric.CreateSuccess.Button.confirm"
    )
    #expect(
        fixLocKey(value: "computer.ok") == "Loc.Computer.ok"
    )
}

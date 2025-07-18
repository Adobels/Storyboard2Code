//
//  convertMultiplierToCode.swift
//  story2code
//
//  Created by Blazej Sleboda on 17/07/2025.
//

func convertMultiplierToCode(_ multiplier: String?) -> String? {
    guard let multiplier, !multiplier.isEmpty else { return nil }
    guard let multiplier = convertMultiplierToFloat(multiplier) else { return "" }
    return "multiplier: " + String(floatToString(multiplier))
    func convertMultiplierToFloat(_ multiplier: String?) -> Float? {
        guard let multiplier, multiplier != nil else { return nil }
        let components = multiplier.components(separatedBy: ":")
        if components.count > 1 {
            let mulitplierValue = Float(components.first!)! / Float(components.last!)!
            return mulitplierValue
        } else {
            return .init(multiplier)!
        }
    }
}

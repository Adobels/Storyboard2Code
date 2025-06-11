//
//  Default.swift
//  story2code
//
//  Created by Blazej Sleboda on 10/06/2025.
//
import story2code
import Testing

@Test func translateActionSelectorToCode() throws {
    #expect(transformMethodName("didTapWithButton:") == "didTap(button:)")
    #expect(transformMethodName("didTap") == "didTap")
    #expect(transformMethodName("didTap:") == "didTap(_:)")
    #expect(transformMethodName("didTap:forEvents:") == "didTap(_:forEvents:)")
    #expect(transformMethodName("didTapWithSender:") == "didTap(sender:)")
    #expect(transformMethodName("didTapWithSender:forEvents:") == "didTap(sender:forEvents:)")

    /*
     <action selector="didTap3" destination="BYZ-38-t0r" eventType="touchDragInside" id="oqx-2l-F2C"/>
     <action selector="didTap4:forEvent:" destination="BYZ-38-t0r" eventType="touchUpOutside" id="GpC-Ir-uoM"/>
     <action selector="didTap5WithSender:forEvent:" destination="BYZ-38-t0r" eventType="touchDragExit" id="Hem-2r-gy3"/>
     <action selector="didTap6WithButton:" destination="BYZ-38-t0r" eventType="touchDragEnter" id="lQb-S9-AZZ"/>
     <action selector="didTap:" destination="BYZ-38-t0r" eventType="touchDragOutside" id="WTL-xZ-wc5"/>
     <action selector="didTap:" destination="BYZ-38-t0r" eventType="touchUpInside" id="sqp-Vp-a3K"/>

     UIButton().addTarget(destination, action: #selector(didTap0), for: .allEditingEvents)

     _ = #selector(didTap0(_:))
     _ = #selector(didTap2(_:))
     _ = #selector(didTap3)
     _ = #selector(didTap4(_:forEvent:))
     _ = #selector(didTap5(sender:forEvent:))
     _ = #selector(didTap6(button:))

     @IBAction func didTap0(_ sender: Any) {
     }

     @IBAction func didTap2(_ sender: UIButton) {
     }

     @IBAction func didTap3() {
     }

     @IBAction func didTap4(_ sender: UIButton, forEvent event: UIEvent) {
     }

     @IBAction func didTap5(sender: UIButton, forEvent event: UIEvent) {

     }

     @IBAction func didTap6(button: Any) {

     }
     */
}

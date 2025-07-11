//
//  parseDatePicker.swift
//  story2code
//
//  Created by Blazej Sleboda on 01/07/2025.
//

import StoryboardDecoder

func parseDatePicker(of view: DatePicker) -> [String] {
    var result = [String]()
    result.append(contentsOf: parseView(of: view))
    result.append(contentsOf: parseControl(of: view))
    if let value = view.style {
        result.append("$0.datePickerStyle = .\(value)") // automatic, compact, inline, wheels
    }
    if let value = view.contentMode {
        result.append("$0.datePickerMode = .\(value)") // time, date, dateAndTime, yearAndMonth, countDownTimer
    }
    if let value = view.locale {
        result.append("$0.locale = .\(value)")
    }
    result.append("$0.minuteInterval = \(view.minuteInterval)")
    if let value = view.date {
        result.append("$0.date = \(value)")
    }
    if let value = view.minimumDate {
        result.append("$0.minimumDate = \(value)")
    }
    if let value = view.maximumDate {
        result.append("$0.maximumDate = \(value)")
    }
    return result
}

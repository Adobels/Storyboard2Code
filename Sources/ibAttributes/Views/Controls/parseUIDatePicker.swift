//
//  parseUIDatePicker.swift
//  story2code
//
//  Created by Blazej Sleboda on 01/07/2025.
//

import StoryboardDecoder

func parseUIDatePicker(of view: DatePicker) -> [String] {
    var result = [String]()
    if let value = view.style {
        result.append("$0.datePickerStyle = .\(value)") // automatic, compact, inline, wheels
    }
    if let value = view.contentMode {
        result.append("$0.datePickerMode = .\(value)") // time, date, dateAndTime, yearAndMonth, countDownTimer
    }
    //missing support view.locale
    if let value = view.minuteInterval {
        result.append("$0.minuteInterval = \(value)")
    }
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

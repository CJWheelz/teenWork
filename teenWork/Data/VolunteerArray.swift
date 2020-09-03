//
//  VolunteerArray.swift
//  teenWork
//
//  Created by CJ Wheelan on 4/18/20.
//  Copyright © 2020 CJ Wheelan. All rights reserved.
//

import Foundation
import SwiftUI

// Specify date components
func CreateDate(year : Int, month : Int, day : Int, hour : Int, minute : Int) -> Date? {
    var dateComponents = DateComponents()
    dateComponents.year = year
    dateComponents.month = month
    dateComponents.day = day
    dateComponents.timeZone = TimeZone(abbreviation: "EST")
    dateComponents.hour = hour
    dateComponents.minute = minute
    dateComponents.weekday = 1
    // Create date from components
    let userCalendar = Calendar.current // user calendar
    let someDateTime = userCalendar.date(from: dateComponents)
    return someDateTime
}

class Volunteers : ObservableObject {
    
    @Published var list = [volunteer(name: "Bake Cookies", date: CreateDate(year: 2020, month: 5, day: 3, hour: 19, minute: 20) ?? Date(), duration: 2.5, description: "Come and bake cookies for those in need.", contact: "YIA@gmail.com", town: "Hanover", user: "B@b.com", posted: CreateDate(year: 2020, month: 3, day: 22, hour: 14, minute: 30) ?? Date()),
                           volunteer(name: "Code Club", date: CreateDate(year: 2020, month: 7, day: 12, hour: 15, minute: 30) ?? Date(), duration: 1.5, description: "Come and help ten and up kids learn how to code.", contact: "Howe@library.org", town: "Hanover", user: "B@b.com", posted: CreateDate(year: 2020, month: 1, day: 22, hour: 8, minute: 0) ?? Date()),
                            volunteer(name: "Help the Homeless", date: CreateDate(year: 2020, month: 6, day: 27, hour: 16, minute: 15) ?? Date(), duration: 2, description: "Help sew blankets for homeless people.", contact: "YIA@gmail.com", town: "Canaan", user: "cj@gmail.com", posted: CreateDate(year: 2020, month: 2, day: 5, hour: 21, minute: 55) ?? Date())]
}

//
//  Jobs.swift
//  teenWork
//
//  Created by CJ Wheelan on 4/12/20.
//  Copyright © 2020 CJ Wheelan. All rights reserved.
//

import Foundation
import SwiftUI

class Jobs : ObservableObject {

    @Published var jobList = [
        job(name: "House Sitting", pay: 10.5, hours: 2.5, totalPay: 26.25, description: "Come and take care of plants and our dog.", contact: "leahwheelan@gmail.com", town: "Hanover", user: "cjwheelan@gmail.com", date: CreateDate(year: 2020, month: 4, day: 29, hour: 8, minute: 30) ?? Date(), posted: CreateDate(year: 2020, month: 3, day: 22, hour: 7, minute: 0) ?? Date()),
        
        job(name: "Lawn Mowing", pay: 8, hours: 3, totalPay: 24, description: "Come on your own time and mow our lawn.", contact: "Bob@gmail.com", town: "Canaan", user: "B@b.com", date: CreateDate(year: 2020, month: 6, day: 15, hour: 22, minute: 30) ?? Date(), posted: CreateDate(year: 2020, month: 3, day: 24, hour: 7, minute: 0) ?? Date()),
        
        job(name: "Dog Walking", pay: 10, hours: 2, totalPay: 20, description: "Come three times a day for two days and walk our golden retriever.", contact: "Karenmom@gmail.com", town: "Norwich", user: "B@b.com", date: CreateDate(year: 2020, month: 6, day: 22, hour: 18, minute: 30) ?? Date(), posted: CreateDate(year: 2020, month: 4, day: 22, hour: 7, minute: 0) ?? Date()),
        
        job(name: "Weeding", pay: 11, hours: 4, totalPay: 44, description: "Come and pull up some weeds.", contact: "charleswheelan@gmail.com", town: "Lyme", user: "cjwheelan@gmail.com", date: CreateDate(year: 2020, month: 7, day: 1, hour: 18, minute: 30) ?? Date(), posted: CreateDate(year: 2020, month: 4, day: 17, hour: 17, minute: 0) ?? Date())]
}

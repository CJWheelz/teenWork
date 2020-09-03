//
//  Data.swift
//  teenWork
//
//  Created by CJ Wheelan on 3/18/20.
//  Copyright © 2020 CJ Wheelan. All rights reserved.
//

import Foundation
import SwiftUI

struct job : Identifiable {
    var id = UUID()
    var name : String
    var pay : Double
    var hours : Double
    var totalPay : Double
    var description : String
    var contact : String
    var town : String
    var user : String
    var date : Date
    var posted : Date
}

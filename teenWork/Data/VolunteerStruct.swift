//
//  VolunteerStruct.swift
//  teenWork
//
//  Created by CJ Wheelan on 4/16/20.
//  Copyright © 2020 CJ Wheelan. All rights reserved.
//

import Foundation
import SwiftUI

struct volunteer : Identifiable {
    var id = UUID()
    var name : String
    var date : Date
    var duration : Double
    var description : String
    var contact : String
    var town : String
    var user : String
    var posted : Date
}

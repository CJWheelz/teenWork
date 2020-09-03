//
//  VolunteerRowView.swift
//  teenWork
//
//  Created by CJ Wheelan on 4/18/20.
//  Copyright © 2020 CJ Wheelan. All rights reserved.
//

import SwiftUI

struct VolunteerRowView: View {
    
    var volunteer : volunteer
    
    var body: some View {
   
        Text(volunteer.name)
            .font(.title)
            .bold()
                
    }
}

struct VolunteerRowView_Previews: PreviewProvider {
    static var previews: some View {
        VolunteerRowView(volunteer: volunteer(name: "Bake Cookies", date: Date(), duration: 2.5, description: "Come and bake cookies for those in need.", contact: "YIA@gmail.com", town: "Hanover", user: "B@b.com", posted: Date()))
    }
}

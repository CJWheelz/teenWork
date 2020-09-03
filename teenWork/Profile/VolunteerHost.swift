//
//  VolunteerHost.swift
//  teenWork
//
//  Created by CJ Wheelan on 5/9/20.
//  Copyright © 2020 CJ Wheelan. All rights reserved.
//

import SwiftUI

struct VolunteerHost: View {
    
    // @EnvironmentObject var currentUser : CurrentUser
    // @EnvironmentObject var towns : Towns
    @EnvironmentObject var volunteers : Volunteers
    
    var volunteer : volunteer
    
    @State private var isShown = false
    
    var body: some View {
        
        VStack {
            
            VolunteerDetailView(volunteer: volunteer)
    
            
        }.navigationBarItems(trailing: Button("Edit") {
            self.isShown.toggle()
        })
        .sheet(isPresented: $isShown) {
            VolunteerEditor(isShown: self.$isShown, volunteer: self.volunteer)
                .environmentObject(Towns())
                .environmentObject(self.volunteers)
        }
    }
}

struct VolunteerHost_Previews: PreviewProvider {
    static var previews: some View {
        VolunteerHost(volunteer: volunteer(name: "Bake Cookies", date: Date(), duration: 2.5, description: "Come and bake cookies for those in need.", contact: "YIA@gmail.com", town: "Hanover", user: "B@b.com", posted: Date()))
            .environmentObject(Volunteers())
    }
}

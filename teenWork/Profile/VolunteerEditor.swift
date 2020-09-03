//
//  VolunteerEditor.swift
//  teenWork
//
//  Created by CJ Wheelan on 5/10/20.
//  Copyright © 2020 CJ Wheelan. All rights reserved.
//

import SwiftUI

struct VolunteerEditor: View {
    
    @Binding var isShown : Bool
    
    @EnvironmentObject var towns : Towns
    @EnvironmentObject var volunteers : Volunteers
    
    @State private var name = ""
    @State private var newDate = false
    @State private var date = Date()
    @State private var duration = ""
    @State private var description = ""
    @State private var newTown = false
    @State private var townChoice = 0
    @State private var newContact = false
    @State private var email = ""
    
    var volunteer : volunteer
    
    var index : Int? {
        let index = volunteers.list.firstIndex { (item) -> Bool in
            item.id == volunteer.id
        }
        
        return index ?? nil
    }
    
    var body: some View {
        NavigationView {
            Form {
                
                // Name
                Section(header: Text("Name")) {
                    TextField("\(volunteer.name)", text: $name)
                }.font(.largeTitle)
                
                // Date
                Section(header: Text("Date")) {
                    Toggle(isOn: $newDate.animation()) {
                        Text("New Date")
                    }
                    
                    if newDate {
                        
                        DatePicker(selection: $date, in: Date()...) {
                            Text("Select a date")
                        }
                    }
                }
                
                // Duration
                Section(header: Text("Duration")) {
                    TextField("\(String(volunteer.duration))", text: $duration)
                        .keyboardType(.decimalPad)
                }
                
                // Description
                Section(header: Text("Description"))
                {
                    TextField("\(volunteer.description)", text: $description)
                }
                
                // Town
                Section(header: Text("Town"))
                {
                    Toggle(isOn: $newTown.animation()) {
                        Text("New Town")
                    }
                    
                    if self.newTown {
                        
                        Picker("Town", selection: self.$townChoice) {
                            ForEach(0 ..< self.towns.townList.count) {
                                Text(self.towns.townList[$0])
                            }
                        }
                    }
                }
                
                // Contact Info
                Section(header: Text("Contact Email")) {
                    Toggle(isOn: $newContact.animation()) {
                        Text("Change Contact Email")
                    }
                    
                    if newContact {
                        TextField("\(volunteer.contact)", text: $email)
                            .keyboardType(.emailAddress)
                    }
                }
                
            }.navigationBarItems(trailing: Button("Done") {
                if self.index != nil {
                    
                    // Name
                    self.volunteers.list[self.index!].name = self.name != "" ? self.name : self.volunteer.name
                    
                    // Date
                    self.volunteers.list[self.index!].date = self.newDate ? self.date : self.volunteer.date
                    
                    // Duration
                    self.volunteers.list[self.index!].duration = self.duration != "" ? Double(self.duration)! : self.volunteer.duration
                    
                    // Description
                    self.volunteers.list[self.index!].description = self.description != "" ? self.description : self.volunteer.description
                    
                    // Town
                    self.volunteers.list[self.index!].town = self.newTown ? self.towns.townList[self.townChoice] : self.volunteer.town
                    
                    // Contact
                    self.volunteers.list[self.index!].contact = self.newContact && self.email != "" ? self.email : self.volunteer.contact
                }
                
                self.isShown.toggle()
            })
            .navigationBarTitle(Text("Edit Volunteer Post"))
        }
    }
}

struct VolunteerEditor_Previews: PreviewProvider {
    static var previews: some View {
        VolunteerEditor(isShown: Binding.constant(true), volunteer: volunteer(name: "Bake Cookies", date: Date(), duration: 2.5, description: "Come and bake cookies for those in need.", contact: "YIA@gmail.com", town: "Hanover", user: "B@b.com", posted: Date()))
        .environmentObject(Towns())
        .environmentObject(Volunteers())
    }
}

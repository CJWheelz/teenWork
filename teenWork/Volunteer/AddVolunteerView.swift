//
//  AddVolunteerView.swift
//  teenWork
//
//  Created by CJ Wheelan on 4/30/20.
//  Copyright © 2020 CJ Wheelan. All rights reserved.
//

import SwiftUI

struct AddVolunteerView: View {
    
    @Binding var thisViewIsShown : Bool
    
    @State private var name = ""
    @State private var date = Date()
    @State private var duration = ""
    @State private var description = ""
    @State private var townChoice = 0
    @State private var newContact = false
    @State private var email = ""
    
    @State private var message = ""
    @State private var alertIsShown = false
    
    @EnvironmentObject var currentUser : CurrentUser
    @EnvironmentObject var towns : Towns
    @EnvironmentObject var volunteers : Volunteers
    
    var body: some View {
        NavigationView {
            Form {
                
                // Name
                Section(header: HStack {
                    Text("Name")
                    Image(systemName: "staroflife.fill")
                        .foregroundColor(.red)
                        .font(.footnote)
                }) {
                    TextField("Name your listing", text: $name)
                        .font(.largeTitle)
                }
                
                // Date
                Section(header: HStack {
                    Text("Date")
                    Image(systemName: "staroflife.fill")
                        .foregroundColor(.red)
                        .font(.footnote)
                }) {
                    DatePicker(selection: $date, in: Date()...) {
                        Text("Select a date")
                    }
                }
                
                // Duration
                Section(header: HStack {
                    Text("Duration")
                    Image(systemName: "staroflife.fill")
                        .foregroundColor(.red)
                        .font(.footnote)
                }) {
                    TextField("Duration of your listing.", text: $duration)
                        .keyboardType(.decimalPad)
                }
                
                // Description
                Section(header: HStack {
                    Text("Volunteer Description")
                    Image(systemName: "staroflife.fill")
                    .foregroundColor(.red)
                    .font(.footnote)
                }) {
                    TextField("Tell us more about this listing.", text: $description)
                }
                
                // Town
                Section(header: HStack {
                    Text("Choose a Town")
                    Image(systemName: "staroflife.fill")
                    .foregroundColor(.red)
                    .font(.footnote)
                }) {
                    Picker("Town", selection: self.$townChoice) {
                        ForEach(0 ..< self.towns.townList.count) {
                            Text(self.towns.townList[$0])
                        }
                    }
                }
                
                // Contact
                Section(header: Text("Contact Info (Account Email Default)")) {
                    Toggle(isOn: $newContact.animation()) {
                        Text("Contact email is different from this email")
                    }
                    
                    if newContact {
                        TextField("Enter New Email", text: $email)
                            .keyboardType(.emailAddress)
                    }
                }
                
                Button(action: {
                    if self.name == ""
                    {
                        self.message = "Please name your job."
                        self.alertIsShown.toggle()
                    }
                    else if self.duration == ""
                    {
                        self.message = "Please provide a duration for your listing."
                        self.alertIsShown.toggle()
                    }
                    else if self.description == ""
                    {
                        self.message = "Please provide a description for your job."
                        self.alertIsShown.toggle()
                    }
                    else
                    {
                        self.volunteers.list.append(volunteer(name: self.name, date: self.date, duration: Double(self.duration)!, description: self.description, contact: self.newContact && self.email != "" ? self.email : self.currentUser.userEmail, town: self.towns.townList[self.townChoice], user: self.currentUser.userEmail, posted: Date()))
                        
                        self.thisViewIsShown.toggle()
                    }
                    
                }) {
                    HStack {
                        Spacer()
                        
                        Text("Post!")
                            .padding(.horizontal, 100)
                            .padding(.vertical)
                            .background(Color.green)
                            .cornerRadius(20)
                            .foregroundColor(.white)
                        
                        Spacer()
                    }
                }
                
            }.navigationBarTitle("Add Volunteer Listing")
            .navigationBarItems(trailing: Button(action: {
                
                self.thisViewIsShown.toggle()
            
            }, label: {
                Text("Cancel")
            }))
            .alert(isPresented: $alertIsShown) { () -> Alert in
                return Alert(title: Text(self.message))
            }
        }
    }
}

struct AddVolunteerView_Previews: PreviewProvider {
    static var previews: some View {
        AddVolunteerView(thisViewIsShown: Binding.constant(true))
        .environmentObject(CurrentUser())
        .environmentObject(Towns())
        .environmentObject(Volunteers())
    }
}

//
//  AddJobView.swift
//  teenWork
//
//  Created by CJ Wheelan on 3/22/20.
//  Copyright © 2020 CJ Wheelan. All rights reserved.
//

import SwiftUI

struct AddJobView: View {
    
    @Binding var isShown : Bool
    
    @State private var name = ""
    @State private var date = Date()
    @State private var pay = ""
    @State private var hours = ""
    @State private var totalPay = ""
    @State private var description = ""
    @State private var townChoice = 0
    @State private var newContact = false
    @State private var email = ""
    
    @State private var alertIsShown = false
    @State private var message = ""
    
    @EnvironmentObject var currentUser : CurrentUser
    @EnvironmentObject var towns : Towns
    @EnvironmentObject var jobs : Jobs
    
    var currentTotal : Double {
        if self.pay == "" || self.hours == "" {
            return 0
        }
        else {
            return Double(self.pay)! * Double(self.hours)!
        }
        
    }
    
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
                    TextField("Name your job", text: $name)
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
                
                // Pay
                Section(header: HStack {
                    Text("Hourly Pay")
                    Image(systemName: "staroflife.fill")
                        .foregroundColor(.red)
                        .font(.footnote)
                }) {
                    
                    TextField("Enter the estimated hourly pay", text: $pay)
                        .keyboardType(.decimalPad)
                    
                }
                
                // Hours
                Section(header: HStack {
                    Text("Total Hours Required")
                    Image(systemName: "staroflife.fill")
                    .foregroundColor(.red)
                    .font(.footnote)
                }) {
                    TextField("Enter the estimated hours of work", text: $hours)
                        .keyboardType(.decimalPad)
                }
                
                // Total Pay
                Section(header: Text("Total Pay")
                ) {
                    Text("Total Pay: $\(self.currentTotal, specifier: "%.2f")")
                }
                
                // Description
                Section(header: HStack {
                    Text("Job Description")
                    Image(systemName: "staroflife.fill")
                    .foregroundColor(.red)
                    .font(.footnote)
                }) {
                    TextField("Elaborate further on what the job entails", text: $description)
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
                
                // Contact Info
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
                    else if self.pay == ""
                    {
                        self.message = "Please provide an hourly pay for your job."
                        self.alertIsShown.toggle()
                    }
                    else if self.hours == ""
                    {
                        self.message = "Please provide the number of hours for your job."
                        self.alertIsShown.toggle()
                    }
                    else if self.description == ""
                    {
                        self.message = "Please provide a description for your job."
                        self.alertIsShown.toggle()
                    }
                    
                    else {
                        self.jobs.jobList.append(job(name: self.name, pay: Double(self.pay)!, hours: Double(self.hours)!, totalPay: self.currentTotal, description: self.description, contact: self.newContact && self.email != "" ? self.email : self.currentUser.userEmail, town: self.towns.townList[self.townChoice], user: self.currentUser.userEmail, date: self.date, posted: Date()))
                        
                        self.isShown.toggle()
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
                
                }.navigationBarTitle("Add a New Job")
                .navigationBarItems(trailing: Button(action: {
                    
                    self.isShown.toggle()
                
                }, label: {
                    Text("Cancel")
                }))
                .alert(isPresented: $alertIsShown) { () -> Alert in
                    return Alert(title: Text(self.message))
                }
        }
    }
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct AddJobView_Previews: PreviewProvider {
    static var previews: some View {
        AddJobView(isShown: Binding.constant(true))
            .environmentObject(CurrentUser())
            .environmentObject(Towns())
            .environmentObject(Jobs())
    }
}

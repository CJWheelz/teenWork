//
//  JobEditor.swift
//  teenWork
//
//  Created by CJ Wheelan on 5/15/20.
//  Copyright © 2020 CJ Wheelan. All rights reserved.
//

import SwiftUI

struct JobEditor: View {
    
    @Binding var isShown : Bool
    
    @EnvironmentObject var towns : Towns
    @EnvironmentObject var jobs : Jobs
    
    @State private var name = ""
    @State private var newDate = false
    @State private var date = Date()
    @State private var pay = ""
    @State private var hours = ""
    @State private var totalPay = ""
    @State private var description = ""
    @State private var newTown = false
    @State private var townChoice = 0
    @State private var newContact = false
    @State private var email = ""
    
    var job : job
    
    var index : Int? {
        
        let index = jobs.jobList.firstIndex { (item) -> Bool in
            item.id == job.id
        }
        
        return index ?? nil
    }
    
    var currentTotal : Double {
        
        if self.pay == "" && self.hours == "" {
            return job.totalPay
        }
        else if self.pay != "" && self.hours == "" {
            return Double(self.pay)! * job.hours
        }
        else if self.pay == "" && self.hours != "" {
            return job.pay * Double(self.hours)!
        }
        else {
            return Double(self.pay)! * Double(self.hours)!
            
        }
    }
    
    var body: some View {
        NavigationView {
            Form {
                
                // Name
                Section(header: Text("Name")) {
                    TextField("\(job.name)", text: $name)
                }.font(.largeTitle)
                
                // Date
                Section(header: Text("Date")) {
                    
                    Toggle(isOn: $newDate.animation()) {
                        Text("New Date")
                    }
                    
                    if newDate {
                        
                        DatePicker(selection: $date, in: Date()...) {
                            Text("Select a Date")
                        }
                    }
                }
                
                // Pay
                Section(header: Text("Hourly Pay")) {
                    TextField("$\(job.pay, specifier: "%.2f")", text: $pay)
                        .keyboardType(.decimalPad)
                }
                
                // Hours
                Section(header: Text("Hours")) {
                    TextField("\(String(job.hours))", text: $hours)
                        .keyboardType(.decimalPad)
                }
                
                // Total Pay
                Section(header: Text("Total Pay")) {
                    
                    Text("Total Pay: $\(self.currentTotal, specifier: "%.2f")")
                        .font(.headline)
                    
                    
                }
                
                // Description
                Section(header: Text("Description")) {
                    TextField("\(job.description)", text: $description)
                }
                
                // Town
                Section(header: Text("Town")) {
                    Toggle(isOn: $newTown.animation()) {
                        Text("New Town")
                    }
                    
                    if newTown {
                        Picker("Town", selection: $townChoice) {
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
                        TextField("\(job.contact)", text: $email)
                            .keyboardType(.emailAddress)
                    }
                }
                
            }.navigationBarTitle("Edit Job Posting")
            .navigationBarItems(trailing: Button("Done") {
                if self.index != nil {
                    
                    // Name
                    self.jobs.jobList[self.index!].name = self.name != "" ? self.name : self.job.name
                    
                    // Date
                    self.jobs.jobList[self.index!].date = self.newDate ? self.date : self.job.date
                    
                    // Pay
                    self.jobs.jobList[self.index!].pay = self.pay != "" ? Double(self.pay)! : self.job.pay
                    
                    // Hours
                    self.jobs.jobList[self.index!].hours = self.hours != "" ? Double(self.hours)! : self.job.hours
                    
                    // Total Pay
                    self.jobs.jobList[self.index!].totalPay = self.currentTotal
                    
                    // Description
                    self.jobs.jobList[self.index!].description = self.description != "" ? self.description : self.job.description
                    
                    // Town
                    self.jobs.jobList[self.index!].town = self.newTown ? self.towns.townList[self.townChoice] : self.job.town
                    
                    // Contact
                    self.jobs.jobList[self.index!].contact = self.newContact && self.email != "" ? self.email : self.job.contact
                   
                }
                self.isShown.toggle()
            })
        }
    }
}

struct JobEditor_Previews: PreviewProvider {
    static var previews: some View {
        JobEditor(isShown: Binding.constant(true), job: job(name: "House Sitting", pay: 10.5, hours: 2.5, totalPay: 26.25, description: "Come and take care of plants and our dog.", contact: "leahwheelan@gmail.com", town: "Hanover", user: "cjwheelan@gmail.com", date: CreateDate(year: 2020, month: 5, day: 29, hour: 8, minute: 30) ?? Date(), posted: CreateDate(year: 2020, month: 3, day: 22, hour: 7, minute: 0) ?? Date()))
            .environmentObject(Towns())
            .environmentObject(Jobs())
    }
}

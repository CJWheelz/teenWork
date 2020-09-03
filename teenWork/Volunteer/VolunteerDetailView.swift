//
//  VolunteerDetailView.swift
//  teenWork
//
//  Created by CJ Wheelan on 4/18/20.
//  Copyright © 2020 CJ Wheelan. All rights reserved.
//

import SwiftUI
import MessageUI

struct VolunteerDetailView: View {
    
    var volunteer : volunteer
    
    @State var result: Result<MFMailComposeResult, Error>? = nil
    @State var isShowingMailView = false

    var times : [String] {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = .full
        
        let date1 = dateFormatter.string(from: volunteer.date)
        
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .short
        
        let date2 = dateFormatter.string(from: volunteer.date)
        
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        
        let date3 = dateFormatter.string(from: volunteer.posted)
        return [date1, date2, date3]
    }
    
    var body: some View {
        VStack {
            Text(volunteer.name)
                .font(.largeTitle)
                .bold()
                .padding(.vertical)
            
            Text("On \(self.times[0]) at \(self.times[1])")
            Text("Duration: \(String(self.volunteer.duration)) hours")
                .padding(.bottom, 30)
            
            HStack {
                Text("Town:")
                    .font(.title)
                    .bold()
                Text(self.volunteer.town)
                    .font(.title)
            }.padding(.bottom, 30)
            
            Text("Description:")
                .bold()
            
            Text(volunteer.description)
                .padding(.bottom, 20)
            
            Text("Interested? For more info contact:")
            
            Button(action: {
                self.isShowingMailView.toggle()
            }) {
                Text(volunteer.contact)
            }.disabled(!MFMailComposeViewController.canSendMail())
                .padding(.bottom, 20)
            
            
            Text("Posted by \(volunteer.user) on \(self.times[2])")
                .font(.footnote)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
            
            Spacer()
            
        }.navigationBarTitle(Text("Volunteer Info"), displayMode: .inline)
        .sheet(isPresented: $isShowingMailView) {
                MailView(result: self.$result, email: self.volunteer.contact)
        }
    }
}

struct VolunteerDetailView_Previews: PreviewProvider {
    static var previews: some View {
        VolunteerDetailView(volunteer: volunteer(name: "Bake Cookies", date: Date(), duration: 2.5, description: "Come and bake cookies for those in need.", contact: "YIA@gmail.com", town: "Hanover", user: "B@b.com", posted: Date()))
    }
}

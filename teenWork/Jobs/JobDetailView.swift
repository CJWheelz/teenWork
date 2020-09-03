//
//  JobDetailView.swift
//  teenWork
//
//  Created by CJ Wheelan on 3/18/20.
//  Copyright © 2020 CJ Wheelan. All rights reserved.
//

import SwiftUI
import MessageUI

struct JobDetailView: View {
    
    var job: job
    
    @State var result: Result<MFMailComposeResult, Error>? = nil
    @State var isShowingMailView = false
    
    
    var times : [String] {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = .full
        
        let date1 = dateFormatter.string(from: job.date)
        
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .short
        
        let date2 = dateFormatter.string(from: job.date)
        
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        
        let date3 = dateFormatter.string(from: job.posted)
        return [date1, date2, date3]
    }
    
    var body: some View {
        VStack {
            Text(job.name)
                .font(.largeTitle)
                .bold()
                .padding(.vertical)
            
            Text("On \(self.times[0]) at \(self.times[1])")
                .padding(.bottom)
            
            VStack {
                HStack {
                    
                    Text("Hourly pay: $\(self.job.pay, specifier: "%.2f")")
                        .padding(.leading, 10)
                    
                }
                
                HStack {
                    Text("Estimated hours worked: " + String(job.hours))
                        .padding(.leading, 10)
                    
                   
                }.padding(.bottom, 20)

            }
            
        
            VStack {
                
                
                HStack(alignment: .firstTextBaseline) {
                    Text("Total pay:")
                    
                    Text("$\(self.job.totalPay, specifier: "%.2f")")
                        .font(.title)
                }.padding(.bottom, 30)
                
                HStack {
                    Text("Town:")
                        .font(.title)
                        .bold()
                    Text(self.job.town)
                        .font(.title)
                }.padding(.bottom, 20)
            }
            
            
            VStack {
                Text("Description:")
                    .bold()
           
                Text(job.description)
                    .padding(.horizontal)
                    .padding(.bottom)
                    .multilineTextAlignment(.leading)
              
            }
            
            
            Text("Interested? For more info contact:")
            
            Button(action: {
                self.isShowingMailView.toggle()
            }) {
                Text(job.contact)
            }.disabled(!MFMailComposeViewController.canSendMail())
                .padding(.bottom, 20)
            
            Text("Posted by \(job.user) on \(self.times[2])")
                .font(.footnote)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
            
            Spacer()
            
        }.navigationBarTitle(Text("Job Info"), displayMode: .inline)
        .sheet(isPresented: $isShowingMailView) {
                MailView(result: self.$result, email: self.job.contact)
        }
    }
}

struct JobDetailView_Previews: PreviewProvider {
    static var previews: some View {
        JobDetailView(job: job(name: "House Sitting", pay: 10.5, hours: 2.5, totalPay: 26.25, description: "Come and take care of plants and our dog.", contact: "leahwheelan@gmail.com", town: "Hanover", user: "cjwheelan@gmail.com", date: CreateDate(year: 2020, month: 5, day: 29, hour: 8, minute: 30) ?? Date(), posted: CreateDate(year: 2020, month: 3, day: 22, hour: 7, minute: 0) ?? Date()))
    }
}

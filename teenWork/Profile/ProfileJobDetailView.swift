//
//  ProfileJobDetailView.swift
//  teenWork
//
//  Created by CJ Wheelan on 4/16/20.
//  Copyright © 2020 CJ Wheelan. All rights reserved.
//

import SwiftUI

struct ProfileJobDetailView: View {
    
    @EnvironmentObject var jobs : Jobs
    
    var job: job
    
    @State private var isShown = false
    
    var body: some View {
        
        VStack {
            
            JobDetailView(job: job)
            
        }
        .navigationBarItems(trailing: Button("Edit") {
            self.isShown.toggle()
        })
        .sheet(isPresented: self.$isShown) {
            
            JobEditor(isShown: self.$isShown, job: self.job)
                .environmentObject(Towns())
                .environmentObject(self.jobs)
        }
    }
}

struct ProfileJobDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileJobDetailView(job: job(name: "House Sitting", pay: 10.5, hours: 2.5, totalPay: 26.25, description: "Come and take care of plants and our dog.", contact: "leahwheelan@gmail.com", town: "Hanover", user: "cjwheelan@gmail.com", date: CreateDate(year: 2020, month: 5, day: 29, hour: 8, minute: 30) ?? Date(), posted: CreateDate(year: 2020, month: 3, day: 22, hour: 7, minute: 0) ?? Date()))
        .environmentObject(Jobs())
    }
}

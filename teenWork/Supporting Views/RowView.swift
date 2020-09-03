//
//  RowView.swift
//  teenWork
//
//  Created by CJ Wheelan on 3/18/20.
//  Copyright © 2020 CJ Wheelan. All rights reserved.
//

import SwiftUI

struct RowView: View {
    
    var job : job
    
    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            
            Text(job.name)
                .font(.title)
                .bold()
              
            
            Spacer()
            
            Text("$\(job.totalPay, specifier: "%.2f")")
                .font(.headline)
  
            Text("@ $\(job.pay, specifier: "%.2f")/ hr.")
                .font(.subheadline)
        }
    }
}

struct RowView_Previews: PreviewProvider {
    static var previews: some View {
        RowView(job: job(name: "House Sitting", pay: 10.5, hours: 2.5, totalPay: 26.25, description: "Come and take care of plants and our dog.", contact: "leahwheelan@gmail.com", town: "Hanover", user: "cjwheelan@gmail.com", date: CreateDate(year: 2020, month: 5, day: 29, hour: 8, minute: 30) ?? Date(), posted: CreateDate(year: 2020, month: 3, day: 22, hour: 7, minute: 0) ?? Date()))
    }
}

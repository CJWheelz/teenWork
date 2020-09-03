//
//  FIlterView.swift
//  teenWork
//
//  Created by CJ Wheelan on 3/23/20.
//  Copyright © 2020 CJ Wheelan. All rights reserved.
//

import SwiftUI

struct FilterView: View {
    
    @EnvironmentObject var towns : Towns
    
    static let sortOptions = ["Relevance", "Hourly Pay: High to Low", "Hourly Pay: Low to High", "Total Pay: High to Low", "Total Pay: Low to High", "Date: Most Recent", "Date: Least Recent", "Posted: Newest", "Posted: Oldest"]
    
    @Binding var townChoice : Int
    @Binding var sortChoice : Int
    @Binding var expiredChoice : Bool
    
    @Binding var isShown : Bool
    
    var newTowns : [String]
    {
        var temp = towns.townList
        temp.insert("All", at: 0)
        return temp
    }
    
    var body: some View {
        VStack {
            
            Toggle(isOn: $expiredChoice) {
                Text("Show expired listings")
            }.padding()
            
            Text("Choose a town")
                .font(.headline)
            
            Picker(selection: $townChoice, label: Text("Choose a town"))
            {
                ForEach(0 ..< self.newTowns.count) {
                    Text(self.newTowns[$0])
                }
            }.labelsHidden()
                .pickerStyle(SegmentedPickerStyle())
        
            
            Text("Sort Jobs By:")
                .offset(y: 40)
                .font(.headline)
            Picker("Sort Jobs By:", selection: $sortChoice) {
                ForEach(0 ..< FilterView.self.sortOptions.count) {
                    Text(FilterView.self.sortOptions[$0])
                }
            }.labelsHidden()
            
        }.navigationBarTitle("Filters", displayMode: .inline)
        .navigationBarItems(trailing: Button("Done") {
                self.isShown.toggle()
                
            })

    }
}

struct FilterView_Previews: PreviewProvider {
    static var previews: some View {
        FilterView(townChoice: Binding.constant(0), sortChoice: Binding.constant(0), expiredChoice: Binding.constant(true), isShown: Binding.constant(true))
        .environmentObject(Towns())
    }
}

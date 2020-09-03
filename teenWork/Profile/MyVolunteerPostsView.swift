//
//  MyVolunteerPostsView.swift
//  teenWork
//
//  Created by CJ Wheelan on 5/2/20.
//  Copyright © 2020 CJ Wheelan. All rights reserved.
//

import SwiftUI

struct MyVolunteerPostsView: View {
    
    @EnvironmentObject var currentUser : CurrentUser
    @EnvironmentObject var volunteers : Volunteers
    
    var body: some View {
        List {
            ForEach(self.volunteers.list.filter({
                $0.user == currentUser.userEmail
            })) { post in
                
                NavigationLink(destination: VolunteerHost(volunteer: post)) {
                    
                    VolunteerRowView(volunteer: post)
                    
                }

            }.onDelete(perform: removeRows)
            
        }.navigationBarTitle(Text("My Volunteer Posts"), displayMode: .inline)
        .navigationBarItems(trailing: EditButton())
    }
    
    private func removeRows(at offsets: IndexSet) {
        let temp = volunteers.list.filter {
            $0.user != currentUser.userEmail
        }
        
        volunteers.list = volunteers.list.filter({
            $0.user == currentUser.userEmail
        })
        
        volunteers.list.remove(atOffsets: offsets)
        
        volunteers.list.append(contentsOf: temp)
        
        volunteers.list.shuffle()
    }
}

struct MyVolunteerPostsView_Previews: PreviewProvider {
    static var previews: some View {
        MyVolunteerPostsView()
        .environmentObject(CurrentUser())
        .environmentObject(Volunteers())
    }
}

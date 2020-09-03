//
//  MyPostsView.swift
//  teenWork
//
//  Created by CJ Wheelan on 4/12/20.
//  Copyright © 2020 CJ Wheelan. All rights reserved.
//

import SwiftUI

struct MyPostsView: View {
    
    @EnvironmentObject var currentUser : CurrentUser
    @EnvironmentObject var jobs : Jobs
    
    @Binding var isShown : Bool
    
    var body: some View {
        List {
            ForEach(self.jobs.jobList.filter({
                $0.user == currentUser.userEmail
            })) { job in
                
                NavigationLink(destination: ProfileJobDetailView(job: job)) {
                    
                    RowView(job: job)
                }
                
            }
            .onDelete(perform: removeRows)
            
        }.navigationBarTitle(Text("My Posts"), displayMode: .inline)
        .navigationBarItems(trailing: EditButton())
    }
    
    func removeRows(at offsets: IndexSet) {
        let tmp = jobs.jobList.filter {
            $0.user != currentUser.userEmail
        }
        
        jobs.jobList = jobs.jobList.filter {
            $0.user == currentUser.userEmail
        }
        jobs.jobList.remove(atOffsets: offsets)
        
        jobs.jobList.append(contentsOf: tmp)
        
        jobs.jobList.shuffle()
    }
}

struct MyPostsView_Previews: PreviewProvider {
    static var previews: some View {
        MyPostsView(isShown: Binding.constant(true))
            .environmentObject(CurrentUser())
            .environmentObject(Jobs())
    }
}

//
//  ProfileView.swift
//  teenWork
//
//  Created by CJ Wheelan on 4/11/20.
//  Copyright © 2020 CJ Wheelan. All rights reserved.
//

import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject var currentUser : CurrentUser
    @EnvironmentObject var viewChanger : ViewChanger
    
    @State private var isShown = false
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    NavigationLink(destination: MyPostsView(isShown: self.$isShown), isActive: self.$isShown, label: {
                        
                        Text("View and Edit My Job Posts")
                            .bold()
                           
                        
                        }).padding()
                }
                
                Section {
                    NavigationLink(destination: MyVolunteerPostsView(), label: {

                        Text("View and Edit My Volunteer Posts")
                            .bold()


                        }).padding()
                }
                
                Section {
                    Button(action: {
                        self.viewChanger.page = "view1"
                    }) {
                        HStack {
                            Spacer()
                            Image(systemName: "person.badge.minus.fill")
                            Text("Logout")
                            Spacer()
                                
                        }.padding()
                            .padding(.horizontal, 20)
                            .background(Color.green)
                            .cornerRadius(20)
                            .foregroundColor(.white)
                            .font(Font.callout.bold())
                        
                    }
                }
            }.navigationBarTitle("Me (\(self.currentUser.userEmail))")
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .environmentObject(CurrentUser())
            .environmentObject(ViewChanger())
    }
}

//
//  AppView.swift
//  teenWork
//
//  Created by CJ Wheelan on 3/18/20.
//  Copyright © 2020 CJ Wheelan. All rights reserved.
//

import SwiftUI

struct AppView: View {
    var body: some View {
        TabView {
            ListView()
                .tabItem {
                    VStack {
                        Image(systemName: "dollarsign.circle")
                        Text("Work")
                    }
            }
            
            VolunteerListView()
                .tabItem {
                    VStack {
                        Image(systemName: "smiley")
                        Text("Volunteer")
                    }
            }
            
            ProfileView()
                .tabItem {
                    VStack {
                        Image(systemName: "person")
                        Text("Me")
                    }
            }
        }
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}

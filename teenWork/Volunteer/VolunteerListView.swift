//
//  VolunteerListView.swift
//  teenWork
//
//  Created by CJ Wheelan on 4/16/20.
//  Copyright © 2020 CJ Wheelan. All rights reserved.
//

import SwiftUI

struct VolunteerListView: View {
    
    @EnvironmentObject var volunteers : Volunteers
    @EnvironmentObject var towns : Towns
    @EnvironmentObject var currentUser : CurrentUser
    
    @State private var searchTerm = ""
    @State private var isShown = false
    
    @State private var expiredChoice = true
    @State private var townChoice = 0
    @State private var sortChoice = 0
    
    static let sortChoices = ["Relevance", "Volunteer Date: Soonest", "Volunteer Date: Farthest Off", "Time Posted: Newest", "Time Posted: Oldest", "Duration: Longest", "Duration: Shortest"]
    
    var sortedOpps : [volunteer] {
        var array = self.volunteers.list
        
        if self.townChoice != 0
        {
            array = array.filter {
                $0.town == towns.townList[self.townChoice - 1]
            }
        }
        
        if self.expiredChoice == false
        {
            array = array.filter({
                $0.date > Date()
            })
        }
        
        if sortChoice == 1 {
            array.sort {
                $0.date.compare($1.date) == .orderedAscending
            }
        }
        else if sortChoice == 2 {
            array.sort {
                $0.date.compare($1.date) == .orderedDescending
            }
        }
        else if sortChoice == 3 {
            array.sort {
                $0.posted.compare($1.posted) == .orderedDescending
            }
        }
        else if sortChoice == 4 {
            array.sort {
                $0.posted.compare($1.posted) == .orderedAscending
            }
        }
        else if sortChoice == 5 {
            array.sort {
                $0.duration > $1.duration
            }
        }
        else if sortChoice == 6 {
            array.sort {
                $0.duration < $1.duration
            }
        }
        
        return array
    }
    
    var newTowns : [String]
    {
        var temp = towns.townList
        temp.insert("All", at: 0)
        return temp
    }
    
    var body: some View {
        NavigationView {
            List {
                
               
                SearchBar(text: $searchTerm)
                
                Section {
                    Toggle(isOn: $expiredChoice) {
                        Text("Show Expired Posts").font(.headline)
                    }
                    Picker(selection: $townChoice, label: HStack(spacing: 20) {
                        
                            Image(systemName: "slider.horizontal.3")
                            Text("Filter")
                            Spacer()
                        
                        }.font(Font.title.weight(.semibold)))
                    {
                        ForEach(0 ..< self.newTowns.count) {
                            Text(self.newTowns[$0])
                        }
                    }
                    
                    Picker(selection: $sortChoice, label: HStack(spacing: 20) {
                        
                            Image(systemName: "list.bullet")
                            Text("Sort")
                            //Spacer()
                        
                        }.font(Font.title.weight(.semibold)))
                    {
                        ForEach(0 ..< VolunteerListView.sortChoices.count) {
                            Text(VolunteerListView.sortChoices[$0])
                        }
                    }
                }
                
                Section {
                    ForEach(self.sortedOpps.filter({
                        self.searchTerm.isEmpty ? true : $0.name.localizedCaseInsensitiveContains(self.searchTerm)
                    })) { opp in
                        
                        NavigationLink(destination: VolunteerDetailView(volunteer: opp)) {
                            VolunteerRowView(volunteer: opp)
                        }

                    }
                }
                
                
            }.navigationBarTitle(Text("Volunteer"))
            .navigationBarItems(trailing: Button(action: {
                    
                    self.isShown.toggle()
                    
                }, label: {
                    
                    Image(systemName: "square.and.pencil")
                        .font(Font.largeTitle.weight(.semibold))
                    
                }))
            .sheet(isPresented: $isShown) {
                    
                AddVolunteerView(thisViewIsShown: self.$isShown)
                    .environmentObject(self.currentUser)
                    .environmentObject(self.towns)
                    .environmentObject(self.volunteers)
            }
            .listStyle(GroupedListStyle())
        }
    }
}

struct VolunteerListView_Previews: PreviewProvider {
    static var previews: some View {
        VolunteerListView()
            .environmentObject(Volunteers())
            .environmentObject(Towns())
            .environmentObject(CurrentUser())
    }
}

//
//  ListView.swift
//  teenWork
//
//  Created by CJ Wheelan on 3/18/20.
//  Copyright © 2020 CJ Wheelan. All rights reserved.
//

import SwiftUI

struct ListView: View {
    
    @EnvironmentObject var currentUser : CurrentUser
    @EnvironmentObject var towns : Towns
    @EnvironmentObject var jobs : Jobs
    
    @State private var isShown = false
    @State private var navigationLinkShown = false
    @State private var searchTerm = ""
    
    @State private var expiredChoice = true
    @State private var townChoice = 0
    @State private var sortChoice = 0
   
    static let sortOptions = ["Relevance", "Hourly Pay: High to Low", "Hourly Pay: Low to High", "Total Pay: High to Low", "Total Pay: Low to High", "Date: Most Recent", "Date: Least Recent", "Posted: Newest", "Posted: Oldest"]
    
    var sortedJobs : [job]
    {
        var currentJobs = self.jobs.jobList
        
        if self.townChoice != 0
        {
            currentJobs = currentJobs.filter {
                $0.town == towns.townList[self.townChoice - 1]
            }
        }
        
        if self.expiredChoice == false
        {
            currentJobs = currentJobs.filter({
                $0.date > Date()
            })
        }
        
        
        if self.sortChoice == 1
        {
            currentJobs.sort {
                $0.pay > $1.pay
            }
        }
        else if self.sortChoice == 2
        {
            currentJobs.sort {
                $0.pay < $1.pay
            }
        }
        else if self.sortChoice == 3
        {
            currentJobs.sort {
                $0.totalPay > $1.totalPay
            }
        }
        else if self.sortChoice == 4
        {
            currentJobs.sort {
                $0.totalPay < $1.totalPay
            }
        }
        else if self.sortChoice == 5
        {
            currentJobs.sort {
                $0.date.compare($1.date) == .orderedAscending
            }
        }
        else if self.sortChoice == 6
        {
            currentJobs.sort {
                $0.date.compare($1.date) == .orderedDescending
            }
        }
        else if self.sortChoice == 7
        {
            currentJobs.sort {
                $0.posted.compare($1.posted) == .orderedDescending
            }
        }
        else if self.sortChoice == 8
        {
            currentJobs.sort {
                $0.posted.compare($1.posted) == .orderedAscending
            }
        }
        
        
        return currentJobs
        
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
                           
                        }.font(Font.title.weight(.semibold)))
                    {
                        ForEach(0 ..< ListView.sortOptions.count) {
                            Text(ListView.sortOptions[$0])
                        }
                    }
                }
//                Section {
//
//                    NavigationLink(destination: FilterView(townChoice: self.$townChoice, sortChoice: self.$sortChoice, expiredChoice: self.$expiredChoice, isShown: self.$navigationLinkShown), isActive: $navigationLinkShown) {
//
//                        HStack(spacing: 20) {
//
//                            Image(systemName: "slider.horizontal.3")
//
//
//                            Text("Filter")
//                            Spacer()
//
//
//                        }.font(Font.title.weight(.semibold))
//                    }
//                }
                
                Section {
                    ForEach(self.sortedJobs.filter {
                        self.searchTerm == "" ? true : $0.name.localizedCaseInsensitiveContains(self.searchTerm)
                    }) { job in
                        
                        NavigationLink(destination: JobDetailView(job: job)) {
                            
                            RowView(job: job)
                        }
                        
                    }
                }
            }.navigationBarTitle(Text("Paid Jobs"))
            .navigationBarItems(trailing: Button(action: {
                    
                    self.isShown.toggle()
                    
                }, label: {
                    
                    Image(systemName: "square.and.pencil")
                        .font(Font.largeTitle.weight(.semibold))
                    
                }))
                
            .sheet(isPresented: $isShown) {
                    
                    AddJobView(isShown: self.$isShown)
                        .environmentObject(self.currentUser)
                        .environmentObject(self.towns)
                        .environmentObject(self.jobs)
                    
            }
            .listStyle(GroupedListStyle())
            
            
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
            .environmentObject(CurrentUser())
            .environmentObject(Towns())
    }
}

//
//  MotherView.swift
//  teenWork
//
//  Created by CJ Wheelan on 3/20/20.
//  Copyright © 2020 CJ Wheelan. All rights reserved.
//


import SwiftUI

struct MotherView: View {
    
    @EnvironmentObject var viewChanger : ViewChanger
    
    var body: some View {
        VStack {
            if viewChanger.page == "view1" {
                ContentView()
            }
            else if viewChanger.page == "view2" {
                AppView()
            }
            
        }
    }
}

struct MotherView_Previews: PreviewProvider {
    static var previews: some View {
        MotherView()
            .environmentObject(ViewChanger())
    }
}

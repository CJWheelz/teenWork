//
//  PopoverView.swift
//  teenWork
//
//  Created by CJ Wheelan on 3/17/20.
//  Copyright © 2020 CJ Wheelan. All rights reserved.
//

import SwiftUI

struct PopoverView: View {
    
    @Binding var isShown : Bool
    
    var body: some View {
        
        NavigationView {
            VStack {
                Text("This is the area where local jobs and volunteer opportunities will show up. It can be changed at any time when signing in.")
                .padding()
                .multilineTextAlignment(.center)
                
                Spacer()
                Button(action: {
                    
                    self.isShown.toggle()
                }) {
                    Text("OK!")
                        .padding(.horizontal, 50)
                        .padding(.vertical, 20)
                        .background(Color.blue)
                        .foregroundColor(.white)
                    .cornerRadius(20)
                }
                
                Spacer()
                
            }
            .navigationBarItems(trailing: Button("Done") {
                
                self.isShown.toggle()
            })
        }
    }
}

struct PopoverView_Previews: PreviewProvider {
    static var previews: some View {
        PopoverView(isShown: Binding.constant(true))
    }
}

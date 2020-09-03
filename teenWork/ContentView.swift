//
//  ContentView.swift
//  teenWork
//
//  Created by CJ Wheelan on 3/17/20.
//  Copyright © 2020 CJ Wheelan. All rights reserved.
//

import SwiftUI
import Firebase

struct ContentView: View {
    
    @State private var email = ""
    @State private var password = ""
    @State private var shown = false
    @State private var message = ""
    @State private var signupIsShown = false
    
    @EnvironmentObject var viewChanger : ViewChanger
    @EnvironmentObject var currentUser : CurrentUser
    
    var body: some View {
        VStack(spacing: 20) {
            
            Text("teenWork")
                .font(.largeTitle)
                .bold()
                .padding(.vertical, 70)
            
            HStack {
                Image(systemName: "envelope")
                
                TextField("Email", text: $email)
                        .padding(.horizontal)
                        .keyboardType(.emailAddress)
                    
            }.padding(.horizontal)
            
            Rectangle()
                .frame(width: UIScreen.main.bounds.width - 20, height: 2)
                .foregroundColor(.green)
                .padding(.bottom, 30)
                .offset(y: -10)
            
            HStack {
                Image(systemName: "lock")

                SecureField("Password", text: $password)
                        .padding(.horizontal)
            
            }.padding(.horizontal)
            
            Rectangle()
                .frame(width: UIScreen.main.bounds.width - 20, height: 2)
                .foregroundColor(.green)
                .padding(.bottom, 30)
                .offset(y: -10)

            
            Button(action: {
                
                if self.email == "" || self.password == "" {
                    self.message = "Please enter an email and password :)"
                    self.shown.toggle()
                    return
                }
                
                Auth.auth().signIn(withEmail: self.email, password: self.password) { (result, error) in
                    if error != nil {
                        
                        print((error!.localizedDescription))
                        self.message = error!.localizedDescription
                        self.shown.toggle()
                        return
                    }
                    else {
                        // print("Successfully signed in!")
                        
                        self.currentUser.userEmail = self.email
                        self.viewChanger.page = "view2"
                    }
                }
            }) {
                Text("Sign in")
                    .fontWeight(.bold)
                    .padding(.horizontal, 120)
                    .padding(.vertical, 20)
                    .background(Color.green)
                    .cornerRadius(30)
                    .foregroundColor(.white)
            }.padding(.bottom, 20)
            
            HStack {
                Text("Don't have an account?")
                    .foregroundColor(.gray)
                
                Button(action: {
                    self.signupIsShown.toggle()
                }) {
                    Text("Sign Up")
                }
            }
            
            Spacer()
            
        }.alert(isPresented: $shown) { () -> Alert in
            
            return Alert(title: Text(self.message))
        }
        .sheet(isPresented: $signupIsShown) {
            SignUpView(signupIsShown: self.$signupIsShown)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ViewChanger())
        .environmentObject(CurrentUser())
    }
}

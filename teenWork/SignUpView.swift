//
//  SignUpView.swift
//  teenWork
//
//  Created by CJ Wheelan on 3/22/20.
//  Copyright © 2020 CJ Wheelan. All rights reserved.
//

import SwiftUI
import Firebase

struct SignUpView: View {
    
    @State private var email = ""
    @State private var password = ""
    @State private var message = ""
    @State private var alertIsShown = false
    
    @Binding var signupIsShown : Bool
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                
                Text("Welcome to teenWork")
                    .font(.largeTitle)
                    .bold()
                    .padding(.vertical, 20)
                
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
                        self.message = "Please enter a password that is over 5 characters and an email :)"
                        self.alertIsShown.toggle()
                        return
                    }
                    
                    Auth.auth().createUser(withEmail: self.email, password: self.password) { (result, error) in
                        if error != nil {
                            print(error!.localizedDescription)
                            self.message = error!.localizedDescription
                            self.alertIsShown.toggle()
                            return
                        }
                        else {
                            // print("Successfully created a user!!")
                            
                            self.signupIsShown.toggle()
                        }
                    }
                }) {
                    Text("Create Account!")
                        .fontWeight(.bold)
                        .padding(.horizontal, UIScreen.main.bounds.width / 4)
                        .padding(.vertical, 20)
                        .background(Color.orange)
                        .cornerRadius(30)
                        .foregroundColor(.white)
                }
                
                Spacer()
                
            }.navigationBarItems(leading: Button("Cancel") {
                self.signupIsShown.toggle()
            })
            
        }.alert(isPresented: $alertIsShown) { () -> Alert in
            
            return Alert(title: Text(self.message))
        }
        
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(signupIsShown: Binding.constant(true))
    }
}

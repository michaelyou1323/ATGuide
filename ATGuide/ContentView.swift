//
//  ContentView.swift
//  ATGuide
//
//  Created by Michaelyoussef on 07/10/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var username: String = ""
      @State private var password: String = ""
    @State private var isShowingNewView = false
    var body: some View {
        NavigationView {
            VStack {
                TextField("Username", text: $username)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                
                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle()) 
                    .padding()
                
                Button(action: {
                    // Perform login action
                    isShowingNewView = true
                    login()
                }) {
                    
                        Text("Login")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .foregroundColor(.white) 
                            .background(Color.blue)
                            .cornerRadius(10)
                            .navigationBarTitleDisplayMode(.inline)
                    NavigationLink(destination: MainScreen(), isActive: $isShowingNewView) {
                           
                          }
                }
                .padding()
               
                    Button(action: {
                        // Perform signup action
                      
                        signUp()
                    }) {
                        NavigationLink(destination: SignUp()) {
                            Text("Sign Up")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .foregroundColor(.white)
                                .background(Color.green)
                                .cornerRadius(10)
                            }
                       
                    }
                    .padding()
                }
        
            }
      
       
          
         
        }
    
    func login() {
        
        
         
       }
       
       func signUp() {
        
           print("Sign Up tapped with username: \(username) and password: \(password)")
       }
   
}

#Preview {
    ContentView()
}
